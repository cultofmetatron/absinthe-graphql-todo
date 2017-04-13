defmodule TodoApi.Web.TodoResolver do
  @moduledoc"""
    The todo resolver
    proxies the graphql queries into our database queries
  """
  alias TodoApi.Schema.User
  alias TodoApi.Schema.User.Todo
  alias TodoApi.Schema.User.Label
  alias TodoApi.Repo
  import Ecto.Query

  def all(_args, %{context: %{current_user: current_user}}=info) do
    IO.inspect(current_user)
    todos = current_user
      |> Todo.find_todos_with_label()
      |> Repo.all()
    {:ok, todos}
  end

  

  @doc"""
    creates a todo
  """
  def create(%{labels: labels}=params, %{context: %{current_user: user}}) do
    #use multi for pushing in multiple transactions
    Repo.transaction(fn() -> 
      case Todo.create_changeset(user, params) |> Repo.insert() do
        {:error, message } -> Repo.rollback(message)
        {:ok, %Todo{id: id}}=todo ->
          label_status = Enum.map(labels, fn(label) -> 
            case Label.create_changeset(user, todo, %{text: label}) |> Repo.insert do
              {:error, message } -> Repo.rollback(message)
              {:ok, label} -> {:ok, label}
            end
          end)
        {:ok, todo}
      end
    end)
  end

  def create(params, %{context: %{current_user: user}}) do
    Todo.create_changeset(user, params) |> Repo.insert()
  end

  #note, I can prolly pullsome of this repeat logic into a seperate function
  def update(%{id: id} = params, %{context: %{current_user: user}}) do
    case Repo.get(Todo, id) do
      nil -> {:error, "todo does not exist"}
      %Todo{}=todo ->
        if todo.owner_id == user.id do
          Todo.update_changeset(todo, params)
            |> Repo.update()
        else
          {:error, "todo does not exist"}
        end
    end
  end

  def delete(%{id: id}, %{context: %{current_user: user}}) do
    case Repo.get(Todo, id) do
      nil -> {:error, "todo does not exist"}
      %Todo{}=todo ->
        if todo.owner_id == user.id do
           val = Repo.delete(todo)
           val
        else
          {:error, "todo does not exist"}
        end
    end
  end

end