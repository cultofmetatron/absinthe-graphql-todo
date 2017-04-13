defmodule TodoApi.Web.TodoResolver do
  @moduledoc"""
    The todo resolver
    proxies the graphql queries into our database queries
  """
  alias TodoApi.Schema.User
  alias TodoApi.Schema.User.Todo
  alias TodoApi.Schema.User.Label
  alias TodoApi.Repo
  use Ecto.Schema
  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  def all(%{labels: labels}, %{context: %{current_user: user}}=info) do
    todos = from(t in assoc(user, :todos))
      |> join(:left, [t], l in assoc(t, :labels))
      |> where([t, l], l.text in ^labels)
      |> preload([t, l], [:labels])
      |> distinct(true)
      |> select([t], t)
      |> Repo.all()
    {:ok, todos}
  end
  def all(_args, %{context: %{current_user: current_user}}=info) do
    todos = current_user
      |> Todo.find_todos_with_label()
      |> Repo.all()
    {:ok, todos}
  end


  @doc"""
    creates a todo
  """
  def create(%{labels: labels}=params, %{context: %{current_user: user}}) do
    #rolling it all into a transaction
    transaction = Repo.transaction(fn() -> 
      case Todo.create_changeset(user, params) |> Repo.insert() do
        {:error, message } -> Repo.rollback(message)
        {:ok, %Todo{id: id}=todo} ->
          label_status = Enum.map(labels, fn(label) ->
            case Label.create_changeset(user, todo, %{text: label}) |> Repo.insert do
              {:error, message } -> Repo.rollback(message)
              {:ok, label} -> {:ok, label}
            end
          end)
        todo
      end
    end)
    case transaction do
      {:error, message} -> {:error, message}
      {:ok, todo} -> {:ok, todo |> Repo.preload(:labels)}
    end
  end

  def create(params, %{context: %{current_user: user}}) do
    Todo.create_changeset(user, params) |> Repo.insert()
  end

  def update(%{id: id} = params, %{context: %{current_user: user}}) do
    get_todo_for_owner(id, user, fn(todo) ->
      Todo.update_changeset(todo, params)
        |> Repo.update()
    end)
  end

  def delete(%{id: id}, %{context: %{current_user: user}}) do
    get_todo_for_owner(id, user, fn(todo) ->
      Repo.delete(todo)
    end)
  end

  def add_label(%{id: id, label: label}, %{context: %{current_user: user}}) do
    get_todo_for_owner(id, user, fn(todo) -> 
      Label.create_changeset(user, todo, %{text: label}) |> Repo.insert()
    end)
  end

  def remove_label(%{id: id, label: text}, %{context: %{current_user: user}}) do
    val = get_todo_for_owner(id, user, fn(todo) -> 
      from(l in assoc(todo, :labels))
        |> where([l], l.text == ^text)
        |> first()
    end)
    case val |> Repo.one() do
      nil -> {:error, "label not applied to that todo"}
      label -> label |> Repo.delete()
    end
  end

  @docp"""
    takes an id for a todo and the user. it retrieves the todo from
    the database and if the todo belongs to the current user, we pass the
    retrieved todo into the callback. Wtherwise, we return an error saying it does
    not exist.
  """
  defp get_todo_for_owner(id, user, func) do
    case Repo.get(Todo, id) do
      nil -> {:error, "todo does not exist"}
      %Todo{}=todo ->
        if todo.owner_id == user.id do
           func.(todo)
        else
          {:error, "todo does not exist"}
        end
    end
  end


end