defmodule TodoApi.Web.Repo.Migrations.CreateTodoApi.Web.TodoApi.Schema.User.Todo do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :content, :string
      add :description, :string
      add :done, :boolean, default: false, null: false
      add :owner_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:todos, [:owner_id])
  end
end
