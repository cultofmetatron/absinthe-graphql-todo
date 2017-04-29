defmodule TodoApi.Web.Authenticate do
  @behaviour Plug

  def init(opts), do: opts

  def call(conn, _) do
    conn
  end
end
