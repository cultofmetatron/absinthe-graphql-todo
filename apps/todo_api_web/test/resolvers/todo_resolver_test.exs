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
  alias TodoApi.Web.TodoResolve

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
    test "it should create a todo" do
      assert 5 == 5
    end
  end

  describe "update a todo" do
      
  end

  describe "delete a todo" do
      
  end
  
end