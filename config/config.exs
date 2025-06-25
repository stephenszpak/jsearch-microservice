import Config

# Load environment variables from .env when present
if File.exists?(Path.expand("../.env", __DIR__)) do
  Dotenvy.load()
end

config :job_hunt, ecto_repos: [JobHunt.Repo]

config :job_hunt, JobHunt.Repo,
  database: System.get_env("DB_NAME", "job_hunt_dev"),
  username: System.get_env("DB_USER", "postgres"),
  password: System.get_env("DB_PASS", "postgres"),
  hostname: System.get_env("DB_HOST", "db"),
  pool_size: 10

config :logger, backends: [LoggerJSON]

config :job_hunt, JobHuntWeb.Router,
  port: String.to_integer(System.get_env("PORT", "4000"))

config :job_hunt, JobHunt.Scheduler,
  timezone: "Etc/UTC"

if config_env() == :prod do
  import_config "releases.exs"
end

config :job_hunt, JobHunt.Scheduler,
  jobs: [
    {"@hourly", {JobHunt.Aggregator, :fetch_all, [%{}]}}
  ]
