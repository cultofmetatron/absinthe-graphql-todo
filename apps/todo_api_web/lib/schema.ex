defmodule TodoApi.Web.Schema do
  use Absinthe.Schema
  import_types TodoApi.Web.Schema.Types
  alias TodoApi.Schema.User

  query do

    field :user, :user do
      resolve (&TodoApi.Web.UserResolver.find/2)
        |> handle_errors()
    end

    field :todos, list_of(:todo) do
      arg :labels, list_of(:string)

      resolve (&TodoApi.Web.TodoResolver.all/2)
        |> handle_errors()
        |> require_authenticated()
    end

  end

  mutation do
    # User operations
    @desc"signup a user"
    field :signup, type: :user do
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      arg :password_confirmation, non_null(:string)

      resolve (&TodoApi.Web.UserResolver.signup/2)
        |> handle_errors()
    end

    @desc"sign the user in"
    field :signin, type: :user do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve (&TodoApi.Web.UserResolver.signin/2)
        |> handle_errors()
    end

    # Todo Operations
    field :create_todo, type: :todo do
      arg :content, non_null(:string)
      arg :description, :string
      arg :done, :boolean
      arg :labels, list_of(:string)

      resolve (&TodoApi.Web.TodoResolver.create/2)
        |> handle_errors()
        |> require_authenticated()
    end

    field :update_todo, type: :todo do
      arg :id, non_null(:id)
      arg :content, :string
      arg :description, :string
      arg :done, :boolean

      resolve (&TodoApi.Web.TodoResolver.update/2)
        |> handle_errors()
        |> require_authenticated()
    end

    field :delete_todo, type: :todo do
      arg :id, non_null(:id)

      resolve (&TodoApi.Web.TodoResolver.delete/2)
        |> handle_errors()
        |> require_authenticated()
    end

    field :add_label, type: :label do
      arg :id, non_null(:id)
      arg :label, non_null(:string)

      resolve (&TodoApi.Web.TodoResolver.add_label/2)
        |> handle_errors()
        |> require_authenticated()
    end

    field :remove_label, type: :label do
      arg :id, non_null(:id)
      arg :label, non_null(:string)

      resolve (&TodoApi.Web.TodoResolver.remove_label/2)
        |> handle_errors()
        |> require_authenticated()
    end

  end

  @doc """
    middlware to ensure that the request has an authenticated user
  """
  def require_authenticated(fun) do
    fn source, args, info ->
      case info do
        %{context: %{login_status: :logged_in, current_user: %User{}}} ->
          Absinthe.Resolution.call(fun, source, args, info)
        _ -> {:error, "Unauthorized"}
      end
    end
  end


  @doc """

    intercepts ecto changsets and converts them into a format that
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
