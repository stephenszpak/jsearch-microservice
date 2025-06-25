import Config

config :job_hunt, JobHunt.Repo,
  database: System.fetch_env!("DB_NAME") || "job_hunt_prod",
  username: System.fetch_env!("DB_USER") || "postgres",
  password: System.fetch_env!("DB_PASS") || "postgres",
  hostname: System.fetch_env!("DB_HOST") || "localhost",
  pool_size: String.to_integer(System.get_env("POOL_SIZE", "10"))

config :job_hunt, JobHuntWeb.Router,
  port: String.to_integer(System.fetch_env!("PORT"))
