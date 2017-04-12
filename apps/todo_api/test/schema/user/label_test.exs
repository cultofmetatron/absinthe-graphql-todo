defmodule TodoApi.Test.Schema.LabelTest do
  use TodoApi.DataCase

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
    {:ok, todo} = Todo.create_changeset(user, %{
      content: "here is a test label"
    }) |> Repo.insert()


    %{user: user, todo: todo}
  end

  describe "creating a todo" do
    test "we can apply a label", %{todo: todo, user: user} do
      changeset = Label.create_changeset(user, todo, %{
        text: "ourlabel"
      });
      
      assert changeset.valid?
    end

    test "label must have more than 2 charachters", %{todo: todo, user: user} do
      changeset = Label.create_changeset(user, todo, %{
        text: "o"
      });
      
      refute changeset.valid?
    end


  end

  describe "remove todo from label" do

    setup %{user: user, todo: todo} do


      %{user: user, todo: todo}
    end

    setup do
      
    end
    


  end

 
end