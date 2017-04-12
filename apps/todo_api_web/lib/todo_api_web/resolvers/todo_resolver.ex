defmodule TodoApi.Web.TodoResolver do
  alias TodoApi.Schema.User.Todo

  def all(_args, %{context: %{current_user: current_user}} = info) do
    #IO.inspect(current_user)
    {:ok, TodoApi.Repo.all(Todo)}
  end

  @doc"""
    creates a todo
  """
  def create(%{}, info) do
    IO.inspect(info)
    {:error, "not_implimented"}
  end

end