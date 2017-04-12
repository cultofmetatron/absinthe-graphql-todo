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

    test "it reject creation with ad arguemnts", %{user: user} do
      assert {:error, changeset} = TodoResolver.create(%{
        content: "",
        description: "laundry day is a very dangerous day"
      }, %{context: %{current_user: user}})

      assert [content: {"can't be blank", [validation: :required]}] = changeset.errors
    end
  end

  describe "update a todo" do
      
  end

  describe "delete a todo" do
      
  end
  
end