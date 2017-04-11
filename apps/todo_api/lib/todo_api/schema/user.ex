defmodule TodoApi.Web.TodoApi.Schema.User do
  use Ecto.Schema
  alias TodoApi.Web.TodoApi.Schema.User.Todo
  schema "users" do
    field :email, :string
    field :password_hash, :string

    has_many :todos, Todo

    timestamps()
  end
end
