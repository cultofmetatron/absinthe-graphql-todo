defmodule TodoApi.Web.TodoApi.Schema.User.Todo do
  use Ecto.Schema
  alias TodoApi.Web.TodoApi.Schema.User

  schema "todos" do
    field :content, :string
    field :description, :string
    field :done, :boolean, default: false
    #field :owner, :id, references
    belongs_to :user, User

    timestamps()
  end
end
