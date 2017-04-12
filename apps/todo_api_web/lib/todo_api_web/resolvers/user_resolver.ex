defmodule TodoApi.Web.UserResolver do
  alias TodoApi.Repo
  alias TodoApi.Schema.User
  alias TodoApi.Schema.User.Todo
  
  import Joken

  def find(%{id: id}, _info) do
    case TodoApi.Repo.get(User, id) do
      nil -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end

  def signup(%{email: email, password: password, password_confirmation: password_confirmation}=args, _info) do
    case User.signup_changeset(%User{}, args) |> Repo.insert() do
      {:error, changeset} -> {:error, changeset}
      {:ok, user} -> {:ok, add_jwt(user)}
    end
  end

  def signin(%{email: email, password: password}, _info) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, "User not found"}
      user ->
        if User.check_password(user, password) do
          {:ok, add_jwt(user)}
        else
          {:error, "User not found"}
        end
    end
  end

  @docp"""
    adds the jwt to the user type. for logging in purposes!
  """
  defp add_jwt(%User{}=user) do
    Map.put(user, :jwt, TodoApi.Web.JwtManager.sign_jwt(user))
  end



  

  


end