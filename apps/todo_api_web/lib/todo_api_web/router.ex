defmodule TodoApi.Web.Router do
  use TodoApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    #plug :accepts, ["json"]
    #plug Joken.Plug, verify: &TodoApi.Web.JwtManager.verify_function/0
    plug TodoApi.Web.JwtManager
    plug TodoApi.Web.Authenticate
  end

  scope "/api" do
    pipe_through :api
    forward "/", Absinthe.Plug, schema: TodoApi.Web.Schema
  end

  scope "/", TodoApi.Web do
    pipe_through :browser # Use the default browser stack

    get "/*path", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TodoApi.Web do
  #   pipe_through :api
  # end
end
