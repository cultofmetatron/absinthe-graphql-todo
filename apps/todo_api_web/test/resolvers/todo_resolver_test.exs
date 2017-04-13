defmodule TodoApi.Web.TodoResolverTest do
  @moduledoc"""
    The todo resolver needs to support the following tasks
    - get a list of all todos for the user
    - create a todo for the user
    - update the todo
    - delete the todo
  """
  use TodoApi.Web.ConnCase
  alias TodoApi.Repo
  alias TodoApi.Schema.User
  alias TodoApi.Schema.User.Todo
  alias TodoApi.Schema.User.Label
  alias TodoApi.Web.UserResolver
  alias TodoApi.Web.TodoResolver

  @valid_user_attrs_signup %{
    email: "example@foobar.com",
    password: "ferngully555",
    password_confirmation: "ferngully555"
  }

  setup do
    {:ok, user} = UserResolver.signup(@valid_user_attrs_signup, %{})
    {:ok, %{user: user}}
  end


  describe "create a todo" do
    test "it should create a todo", %{user: user} do
      {:ok, todo} = TodoResolver.create(%{
        content: "do the laundry",
        description: "laundry day is a very dangerous day"
      },  %{context: %{current_user: user}})

      assert todo.content == "do the laundry"
      user = user |> Repo.preload(:todos)
      assert Enum.count(user.todos) == 1
    end

    test "it should create a todo withlabels", %{user: user} do
      {:ok, todo} = TodoResolver.create(%{
        content: "do the laundry",
        description: "laundry day is a very dangerous day",
        labels: ["yolo", "swag"]
      },  %{context: %{current_user: user}})
      assert todo.content == "do the laundry"
      
      
      user = user |> Repo.preload(:todos)
      assert Enum.count(user.todos) == 1
    end

    test "it reject creation with ad arguemnts", %{user: user} do
      assert {:error, changeset} = TodoResolver.create(%{
        content: "",
        description: "laundry day is a very dangerous day"
      }, %{context: %{current_user: user}})

      assert [content: {"can't be blank", [validation: :required]}] = changeset.errors
    end
  end

  describe "modifying a todo" do
    
    setup %{user: user} do
      todo = Todo.create_changeset(user, %{
        content: "I made a todo!!"
      }) |> Repo.insert!()
      {:ok, %{ todo: todo }}      
    end

    test "updates a todo", %{user: user, todo: todo} do
      assert {:ok, todo} = TodoApi.Web.TodoResolver.update(%{
        id: todo.id,
        content: "updated content!",
        done: true
      }, %{context: %{current_user: user}})

      assert todo.content == "updated content!"
      assert todo.done
    end

    test "adds a label to the todo", %{user: user, todo: todo} do
      assert {:ok, %Label{}=label} = TodoResolver.add_label(%{
        id: todo.id,
        label: "yoloswag"
      }, %{context: %{current_user: user}})

      todo = todo |> Repo.preload(:labels)
      assert Enum.count(todo.labels) == 1
    end

    test "removes a label to the todo", %{user: user, todo: todo} do
      assert {:ok, %Label{}=label} = TodoResolver.add_label(%{
        id: todo.id,
        label: "yoloswag"
      }, %{context: %{current_user: user}})

      todo = todo |> Repo.preload(:labels)
      assert Enum.count(todo.labels) == 1

      assert {:ok, %Label{}} = {:ok, %Label{}=label} = TodoResolver.remove_label(%{
        id: todo.id,
        label: "yoloswag"
      }, %{context: %{current_user: user}})

      todo = todo |> Repo.preload(:labels, force: true)
      assert Enum.count(todo.labels) == 0

    end

    test "deletes a todo", %{user: user, todo: todo} do
      assert {:ok, todo} = TodoApi.Web.TodoResolver.delete(%{
        id: todo.id,
      }, %{context: %{current_user: user}})
      #refute that it exists now that we deleted it
      refute Repo.get(Todo, todo.id)

    end

  end

  describe "finding todos" do
    setup %{user: user} do
      {:ok, _} = TodoResolver.create(%{
        content: "todo1",
        labels: ["yolo", "tag1", "SWBeatsItsCompetitors"]
      },  %{context: %{current_user: user}})
      {:ok, _} = TodoResolver.create(%{
        content: "todo2",
        labels: ["yolo", "tag1"]
      },  %{context: %{current_user: user}})
      {:ok, todo} = TodoResolver.create(%{
        content: "laundry time",
        description: "laundry day is a very dangerous day",
        labels: ["yolo", "laundry"]
      },  %{context: %{current_user: user}})
      {:ok, todo} = TodoResolver.create(%{
        content: "sit around",
      },  %{context: %{current_user: user}})

      :ok      
    end

    test "gets all the todos", %{user: user} do
      assert {:ok, todos} = TodoResolver.all(%{}, %{context: %{current_user: user}})
      assert Enum.count(todos) == 4
    end

    test "gets only todos with the label", %{user: user} do
      assert {:ok, todos} = TodoResolver.all(%{labels: ["yolo", "laundry"]}, %{context: %{current_user: user}})
      assert Enum.count(todos) == 3

      assert {:ok, todos} = TodoResolver.all(%{labels: ["laundry"]}, %{context: %{current_user: user}})
      assert Enum.count(todos) == 1

      assert {:ok, todos} = TodoResolver.all(%{labels: ["laundry", "tag1"]}, %{context: %{current_user: user}})
      assert Enum.count(todos) == 3
    end

  end
  
end