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
      (&TodoApi.Web.UserResolver.signup/2)
        |> handle_errors()
        |> resolve()
    end
    
  end

  def handle_errors(fun) do
    fn source, args, info ->
      case Absinthe.Resolution.call(fun, source, args, info) do
        {:error, %Ecto.Changeset{} = changeset} -> format_changeset(changeset)
        val -> val
      end
    end
  end

  def format_changeset(changeset) do
    #{:error, [email: {"has already been taken", []}]}
    errors = changeset.errors
      |> Enum.map(fn({key, {value, context}}) -> 
           [message: "#{key} #{value}", details: context]
         end)
    {:error, errors}
  end


end