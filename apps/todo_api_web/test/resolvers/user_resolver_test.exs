defmodule TodoApi.Web.UserResolverTest do
  use TodoApi.Web.ConnCase
  alias TodoApi.Repo
  alias TodoApi.Schema.User
  alias TodoApi.Schema.User.Todo
  alias TodoApi.Web.UserResolver

  @valid_user_attrs_signup %{
    email: "example@foobar.com",
    password: "ferngully555",
    password_confirmation: "ferngully555"
  }

  @invalid_user_attrs_signup_mismatch_pass %{
    email: "example@foobar.com",
    password: "ferngully555",
    password_confirmation: "ferngully"
  }

  @valid_user_attrs_signin %{
    email: "example@foobar.com",
    password: "ferngully555"
  }

  @invalid_user_attrs_signin_bad_pass %{
    email: "example@foobar.com",
    password: "ferngul"
  }

  @invalid_user_attrs_signin_nonexistant_user %{
    email: "noexist@foobar.com",
    password: "ferngully555"
  }

  describe "signup" do

    test "signup creates a user" do
      assert {:ok, user} = UserResolver.signup(@valid_user_attrs_signup, %{})
      assert user.email == "example@foobar.com"
      refute user.jwt == nil
      
    end

    test "rejects a bad password" do
      assert {:error, changeset} = UserResolver.signup(@invalid_user_attrs_signup_mismatch_pass, %{})
      refute changeset.valid?
      assert [password_confirmation: {"password_confirmation does not match password!", _}] = changeset.errors
    end

  end

  describe "signin" do
    setup do
      User.signup_changeset(%User{}, @valid_user_attrs_signup) |> Repo.insert!()
      :ok
    end

    test "works with valid signin" do
      assert {:ok, user} = UserResolver.signin(@valid_user_attrs_signin, %{})
      assert user.email == "example@foobar.com"
      refute user.jwt == nil
    end

    test "rejects if user does not exist" do
      assert {:error, message } = UserResolver.signin(@invalid_user_attrs_signin_nonexistant_user, %{})
      assert message == "User not found"
    end

    test "rejects if password is wrong" do
      assert {:error, message } = UserResolver.signin(@invalid_user_attrs_signin_bad_pass, %{})
      assert message == "User not found"
    end

  end

end
