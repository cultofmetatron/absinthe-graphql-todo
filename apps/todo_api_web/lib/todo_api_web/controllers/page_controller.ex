defmodule TodoApi.Web.PageController do
  use TodoApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
