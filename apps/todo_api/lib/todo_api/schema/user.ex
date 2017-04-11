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


  def signup_changeset(struct, params \\ %{}) do
    struct
      |> cast(params, [:uid])
      |> validate_required([:uid])
      |> unique_constraint(:uid)
  end




end
