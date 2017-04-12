defmodule TodoApi.Web.Schema do
  use Absinthe.Schema
  import_types TodoApi.Web.Schema.Types

  query do
    
    field :todos, list_of(:todo) do
      resolve &TodoApi.Web.TodoResolver.all/2
    end
  end

  mutation do
    @desc "signup a user"
    field :signup, type: :user do
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      arg :password_confirmation, non_null(:string)
      resolve &TodoApi.Web.UserResolver.signup/2
    end
    
  end

end