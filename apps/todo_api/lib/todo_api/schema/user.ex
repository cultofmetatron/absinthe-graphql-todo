defmodule TodoApi.Schema.User do
  use TodoApi.Api, :schema

  alias TodoApi.Schema.User.Todo
  alias TodoApi.Schema.User.Label
  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    has_many :todos, Todo, foreign_key: :owner_id
    has_many :labels, Label
    has_many(:labeled_todos, through: [:labels, :todo])
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
      |> cast(params, [:email, :password, :password_confirmation])
      |> validate_format(:email, ~r/@/)
      |> validate_length(:password, min: 5)
      |> validate_required([:password, :password_confirmation])
      |> password_and_confirmation_matches()
      |> generate_password_hash()
      |> validate_required([:password_hash])
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
    generates the password hash
  """
  def generate_password_hash(changeset) do
    password = get_change(changeset, :password)
    hash = Comeonin.Bcrypt.hashpwsalt(password)
    changeset |> put_change(:password_hash, hash)
  end




end
