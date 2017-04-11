defmodule TodoApi.Schema.User.Todo do
  use TodoApi.Api, :schema
  alias TodoApi.Schema.User

  schema "todos" do
    field :content, :string
    field :description, :string
    field :done, :boolean, default: false
    #field :owner, :id, references
    belongs_to :user, User

    timestamps()
  end

  @doc"""
    creates a todo
    > user = Repo.get(User, id)
    > todo = user |> Todo.create_changeset(%{
      content: "do the laundry",
      description: "it needs to be nice and light"
    })
  """
  def create_changeset(%User{}=user, params \\ %{}) do
    build_assoc(user, :todos)
      |> cast(params, [:content, :description, :done])
      |> validate_required([:content])
  end

  @doc"""
    updates the todo. must have an existing id
  """
  def update_changeset(struct, params \\%{}) do
    struct
      |> cast(params, [:done, :content, :description])
  end



end
