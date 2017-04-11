defmodule TodoApi.Web.TodoApi.Schema.User do
  use Ecto.Schema

  schema "users" do
    field :email, :string
    field :password_hash, :string

    timestamps()
  end
end
