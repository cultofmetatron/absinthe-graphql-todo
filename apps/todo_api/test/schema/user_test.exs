defmodule LaVoyage.Db.UserTest do
  use TodoApi.DataCase

  alias TodoApi.Web.TodoApi.Schema.User 

  @valid_attrs %{uid: "some content"}
  @valid_signup_attrs %{
    email: "foobar@example.com",
    password: "foobar677"
  }
  @invalid_attrs %{}

  describe "signup changeset" do
    test "works with valid arguments" do
      changeset = User.signup_changeset(%User{}, @valid_signup_attrs)
      assert changeset.valid?
    end

    test "requires a valid email" do
      no_email = %{
        email: "brad",
        password: "asfga67585ASDF"
      }
      changeset = User.signup_changeset(%User{}, no_email)
      assert !changeset.valid?
    end

    test "requires a password with appropriate properties" do
      bad_pass = %{
        email: "brad@example.com",
        pass: "foo"
      }
      changeset = User.signup_changeset(%User{}, bad_pass)
      assert !changeset.valid?
    end


  end


  #test "changeset with invalid attributes" do
  #  changeset = User.changeset(%User{}, @invalid_attrs)
  #  refute changeset.valid?
  #end
end
