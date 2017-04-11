defmodule LaVoyage.Db.UserTest do
  use TodoApi.DataCase

  alias TodoApi.Web.TodoApi.Schema.User 

  @valid_attrs %{uid: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    #changeset = User.changeset(%User{}, @valid_attrs)
    #assert changeset.valid?
  end

  #test "changeset with invalid attributes" do
  #  changeset = User.changeset(%User{}, @invalid_attrs)
  #  refute changeset.valid?
  #end
end
