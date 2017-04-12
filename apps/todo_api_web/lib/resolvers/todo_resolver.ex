defmodule TodoApi.Web.TodoResolver do
  alias TodoApi.Schema.Todo

  def all(_args, _info) do
    {:ok, TodoApi.Repo.all(Todo)}
  end
end