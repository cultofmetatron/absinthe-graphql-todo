defmodule TodoApi.Application do
  @moduledoc """
  The TodoApi Application Service.

  The todo_api system business domain lives in this application.

  Exposes API to clients such as the `TodoApi.Web` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      worker(TodoApi.Repo, []),
    ], strategy: :one_for_one, name: TodoApi.Supervisor)
  end
end
