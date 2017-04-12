defmodule TodoApi.Test.Schema.TodoTest do
  use TodoApi.DataCase
  import Ecto.Query
  alias TodoApi.Schema.User
  alias TodoApi.Schema.User.Todo
  alias TodoApi.Schema.User.Label
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
      [todo | _] = user.todos
      assert todo.content == "do the laundry"
      refute todo.done
      {:ok, todo} = Todo.update_changeset(todo, %{done: true}) |> Repo.update()
      assert todo.done
    end


  end


  describe "finding by label" do
    setup %{user: user}=ctx do
      todo1 = Todo.create_changeset(user, %{
        content: "do the laundry"
      }) |> Repo.insert!()
      
      todo2 = Todo.create_changeset(user, %{
        content: "do the dishes"
      }) |> Repo.insert!()
      
     
      Label.create_changeset(user, todo1, %{
        text: "chores"
      }) |> Repo.insert!()

      Label.create_changeset(user, todo1, %{
        text: "yolo"
      }) |> Repo.insert!()

     
      Map.merge(ctx, %{todos: [todo1, todo2]})
    end

    setup ctx do
      :ok
    end

    test "getting all todos with labels attached", %{user: user} do
      [laundry | _] = Todo.find_todos_with_label(user)
        |> where([t], t.content == "do the laundry")
        |> Repo.all()
      assert Enum.count(laundry.labels) == 2

      [dishes | _] = Todo.find_todos_with_label(user)
        |> where([t], t.content == "do the dishes")
        |> Repo.all()
      assert Enum.count(dishes.labels) == 0

    end
    
    
  end

end