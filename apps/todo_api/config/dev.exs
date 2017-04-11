use Mix.Config

# Configure your database
config :todo_api, TodoApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "todo_api_dev",
  hostname: "localhost",
  pool_size: 10
