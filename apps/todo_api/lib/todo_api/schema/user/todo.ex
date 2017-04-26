defmodule TodoApi.Schema.User.Todo do
  use TodoApi.Api, :schema
  alias TodoApi.Schema.User
  alias TodoApi.Schema.User.Todo
  alias TodoApi.Schema.User.Label

  schema "todos" do
    field :content, :string
    field :description, :string
    field :done, :boolean, default: false
    #field :owner, :id, references
    belongs_to :user, User, foreign_key: :owner_id
    has_many :labels, Label
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
      |> validate_length(:content, min: 1)
      |> unique_constraint(:text, name: :user_todo_text)
      |> assoc_constraint(:user)
  end

  @doc"""
    updates the todo. must have an existing id
  """
  def update_changeset(struct, params \\%{}) do
    struct
      |> cast(params, [:done, :content, :description])
  end

 @doc"""
    return all the todos annotated with the labels attached to them
  """
  def find_todos_with_label(%User{}=user) do
    from(t in assoc(user, :todos))
      |> preload(:labels)
  end 

end
