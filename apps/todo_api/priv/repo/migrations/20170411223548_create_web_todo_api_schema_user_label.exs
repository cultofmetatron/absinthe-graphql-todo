defmodule TodoApi.Web.Repo.Migrations.CreateTodoApi.Web.TodoApi.Schema.User.Label do
  use Ecto.Migration

  def change do
    create table(:labels, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :text, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all,  type: :uuid), null: false
      add :todo_id, references(:todos, on_delete: :delete_all,  type: :uuid), null: false

      timestamps()
    end

    create index(:labels, [:user_id])
    create index(:labels, [:todo_id])
    create index(:labels, [:text])
    create unique_index(:labels, [:user_id, :todo_id, :text], name: :user_todo_text)
  end
end
