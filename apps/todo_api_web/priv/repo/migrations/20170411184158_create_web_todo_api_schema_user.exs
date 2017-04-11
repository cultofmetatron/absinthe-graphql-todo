defmodule TodoApi.Web.Repo.Migrations.CreateTodoApi.Web.TodoApi.Schema.User do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string

      timestamps()
    end

  end
end
