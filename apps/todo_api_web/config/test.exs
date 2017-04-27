use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :todo_api_web, TodoApi.Web.Endpoint,
  http: [port: 4001],
  index: "http://localhost:4001",
  server: true
