defmodule TodoApi.Web.Authenticate do
  @behaviour Plug

  import Plug.Conn
  import Ecto.Query, only: [where: 2]

  alias TodoApi.Repo
  alias TodoApi.Schema.User

  def init(opts), do: opts

  def call(conn, _) do
    IO.inspect(conn)
    conn
  end

  

  
end