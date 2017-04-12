defmodule TodoApi.Web.UserResolver do
  alias TodoApi.Repo
  alias TodoApi.Schema.User
  alias TodoApi.Schema.User.Todo

  def find(%{id: id}, _info) do
    case TodoApi.Repo.get(User, id) do
      nil -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end

  def signup(%{email: email, password: password, password_confirmation: password_confirmation}=args, _info) do
    User.signup_changeset(%User{}, args) |> Repo.insert()
  end

  def signin(%{email: email, password: password}) do

  end

end