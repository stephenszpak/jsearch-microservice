import Config

config :job_hunt, JobHunt.Repo,
  database: "job_hunt_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :logger, level: :warn
