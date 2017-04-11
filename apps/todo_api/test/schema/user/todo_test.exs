defmodule TodoApi.Test.Schema.TodoTest do
  use TodoApi.DataCase

  alias TodoApi.Schema.User
  alias TodoApi.Schema.User.Todo
  alias TodoApi.Web
  alias TodoApi.Repo

  setup do
    user_changeset = User.signup_changeset(%User{}, %{
      email: "foobar@example.com",
      password: "foobar677",
      password_confirmation: "foobar677"
    });
    {:ok, user} = user_changeset |> Repo.insert()
    %{user: user}
  end

  describe "creating a todo" do
    #works with valid arguments
    test "works with valid arguemnts", %{user: user} do
      todo = Todo.create_changeset(user, %{
        content: "do the laundry"
      })

      assert todo.valid?
    end

    test "must have contents", %{user: user} do
      todo = Todo.create_changeset(user, %{
        description: "this won't enter the database"
      })
      refute todo.valid?
    end
  end

  describe "can be marked done" do
    setup %{user: user} do
      todo = Todo.create_changeset(user, %{
        content: "do the laundry"
      }) |> Repo.insert!
      %{todo: todo}
    end

    test "todo can be marked as completed", %{ user: user} do
      user = user |> Repo.preload(:todos)
      IO.inspect(user)
    end


  end

end