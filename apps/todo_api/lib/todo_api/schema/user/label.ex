defmodule TodoApi.Schema.User.Label do
  use Ecto.Schema
  import Ecto.Changeset
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
end
