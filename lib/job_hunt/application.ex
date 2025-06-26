defmodule JobHunt.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      JobHunt.Repo,
      {Registry, keys: :unique, name: JobHunt.WorkerRegistry},
      {JobHunt.Worker, :linkedin},
      {JobHunt.Worker, :indeed},
      {JobHunt.Worker, :glassdoor},
      {JobHunt.Worker, :github},
      {Plug.Cowboy,
       scheme: :http,
       plug: JobHuntWeb.Router,
       options: [
         port: Application.get_env(:job_hunt, JobHuntWeb.Router)[:port],
         protocol_options: [
           request_timeout:
             Application.get_env(:job_hunt, JobHuntWeb.Router)[:read_timeout]
         ]
       ]},
      JobHunt.Scheduler
    ]

    opts = [strategy: :one_for_one, name: JobHunt.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
