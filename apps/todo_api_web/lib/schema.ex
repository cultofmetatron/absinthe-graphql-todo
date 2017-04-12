defmodule TodoApi.Web.Schema do
  use Absinthe.Schema
  import_types TodoApi.Web.Schema.Types
  alias TodoApi.Schema.User

  query do
    
    field :todos, list_of(:todo) do
      (&TodoApi.Web.TodoResolver.all/2)
        |> handle_errors()
        |> require_authenticated()
        |> resolve()
    end

  end

  mutation do
    @desc"signup a user"
    field :signup, type: :user do
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      arg :password_confirmation, non_null(:string)
      (&TodoApi.Web.UserResolver.signup/2)
        |> handle_errors()
        |> resolve()
    end

    @desc"sign the user in"
    field :signin, type: :user do
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      (&TodoApi.Web.UserResolver.signin/2)
        |> handle_errors()
        |> resolve()
    end

  end

  @doc"""
    middlware to ensure that the request has an authenticated user
  """
  def require_authenticated(fun) do
    fn source, args, info ->
      case info do
        %{context: %{login_status: :logged_in, current_user: %User{}=user}} ->
          Absinthe.Resolution.call(fun, source, args, info)
        _ -> {:error, "Unauthorized"}
      end
    end
  end

  @doc"""
    interceptsecto changsets and converts them into a format that 
    absinthe can render in graphql
  """
  def handle_errors(fun) do
    fn source, args, info ->
      case Absinthe.Resolution.call(fun, source, args, info) do
        {:error, %Ecto.Changeset{} = changeset} -> format_changeset(changeset)
        {:error, message} -> {:error, message}
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