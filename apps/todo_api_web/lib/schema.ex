defmodule TodoApi.Web.Schema do
  use Absinthe.Schema
  import_types TodoApi.Web.Schema.Types

  query do
    field :todos, list_of(:todo) do
      resolve &TodoApi.Web.TodoResolver.all/2
    end
  end

end