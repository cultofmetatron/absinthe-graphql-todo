defmodule TodoApi.Web.Repo.Migrations.CreateTodoApi.Web.TodoApi.Schema.User.Label do
  use Ecto.Migration

  def change do
    create table(:labels, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :text, :string
      add :user_id, references(:users, on_delete: :delete_all,  type: :uuid)
      add :todo_id, references(:todos, on_delete: :delete_all,  type: :uuid)

      timestamps()
    end

    create index(:labels, [:user_id])
    create index(:labels, [:todo_id])
    create unique_index(:labels, [:user_id, :todo_id, :text])
  end
end
