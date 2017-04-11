use Mix.Config

config :todo_api, ecto_repos: [TodoApi.Repo]

import_config "#{Mix.env}.exs"
