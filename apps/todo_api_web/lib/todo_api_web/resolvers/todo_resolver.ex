defmodule TodoApi.Web.TodoResolver do
  alias TodoApi.Schema.User.Todo
  import Ecto.Query
  def all(_args, %{context: %{current_user: current_user}} = info) do
    #IO.inspect(current_user)
    current_user |> Repo.preload(:todos)
    {:ok, Repo.all(Todo)}
  end

  @doc"""
    creates a todo
  """
  def create(%{}, info) do
    IO.inspect(info)
    {:error, "not_implimented"}
  end

end