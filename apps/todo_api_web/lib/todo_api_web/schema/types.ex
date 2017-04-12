defmodule TodoApi.Web.Schema.Types do
  use Absinthe.Schema.Notation

  @desc "a user"
  object :user do
    field :id, :id
    field :email, :string
    field :todos, list_of(:todo)
  end

  @desc "a todo"
  object :todo do
    field :id, :id
    field :content, :string
    field :description, :string
  end
end