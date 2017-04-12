defmodule TodoApi.Web.Schema.Types do
  use Absinthe.Schema.Notation

  object :todo do
    field :id, :id
    field :content, :string
    field :description, :string
  end
end