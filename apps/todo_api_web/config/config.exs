# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :todo_api_web,
  namespace: TodoApi.Web,
  ecto_repos: [TodoApi.Repo]

# Configures the endpoint
config :todo_api_web, TodoApi.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XF2q4t42ESD+0yWeSNVxwhYWTBE1+gGqGFlmhyTG4BnXIQmbenaHw3ebgnGqWiMN",
  render_errors: [view: TodoApi.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TodoApi.Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  binary_id: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"


config :todo_api_web, :joken,
  secret: "asfgaksdgfkuasygdkufgadskfglglg2343m2vrmv3kr32riy3v",
  issuer: 123456789
