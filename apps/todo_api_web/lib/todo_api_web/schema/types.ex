defmodule TodoApi.Web.Schema.Types do
  use Absinthe.Schema.Notation

  @desc "a user"
  object :user do
    field :id, :id
    field :email, :string
    field :jwt, :string
    field :todos, list_of(:todo)
  end

  @desc "a todo"
  object :todo do
    field :id, :id
    field :content, :string
    field :description, :string
    field :done, :boolean
    field :labels, list_of(:label)
  end

  @desc "a label"
  object :label do
    field :id, :id
    field :text, :string
    field :todos, list_of(:todo)
  end

end