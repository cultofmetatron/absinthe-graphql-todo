defmodule TodoApi.Web.TodoApi.Schema.User do
  use TodoApi.Api, :schema

  alias TodoApi.Web.TodoApi.Schema.User.Todo
  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    has_many :todos, Todo

    timestamps()
  end


  @doc"""
    requires an email and a password
    {:ok, user } = User.signup_changeset(%User{}, %{
      email: "bob@example.com",
      password: "foobar666"
    }) |> Repo.insert()
  """
  def signup_changeset(struct, params \\ %{}) do
    struct
      |> cast(params, [:uid, :email, :password, :password_confirmation])
      |> validate_required([:uid, :password, :password_confirmation])
      |> unique_constraint(:uid)
      |> unique_constraint(:email)
  end

  @docp """
    confirms that the changeset has a changeset and a confirmation
  """
  def password_and_confirmation_matches(changeset) do
    password = get_change(changeset, :password)
    password_confirmation = get_change(changeset, :password_confirmation)
    if password == password_confirmation do
      changeset
    else
      changeset
        |> add_error(:password_confirmation, "password_confirmation does not match password!")
    end
  end

  @docp """

  """
  def generate_password_hash(changeset) do
    
  end




end
