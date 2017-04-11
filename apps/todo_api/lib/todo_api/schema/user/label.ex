defmodule TodoApi.Schema.User.Label do
  use TodoApi.Api, :schema
  alias TodoApi.Schema.User.Label
  alias TodoApi.Schema.User
  alias TodoApi.Schema.User.Todo


  schema "labels" do
    field :text, :string
    belongs_to :user, User
    belongs_to :todo, Todo

    timestamps()
  end

  @doc false
  def changeset(%Label{} = label, attrs) do
    label
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end

  def add_changeset(%User{}=user, %Todo{}=todo, params \\ %{}) do
    
  end


end
