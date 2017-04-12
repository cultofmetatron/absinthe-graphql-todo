defmodule TodoApi.Web.TodoResolver do
  alias TodoApi.Schema.User.Todo
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
  def create(params, %{context: %{current_user: user}}) do
    IO.inspect(user)
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
           IO.inspect(val)
           val
        else
          {:error, "todo does not exist"}
        end
    end
  end

end