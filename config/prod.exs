import Config

config :job_hunt, JobHunt.Repo,
  database: System.fetch_env!("DB_NAME"),
  username: System.fetch_env!("DB_USER"),
  password: System.fetch_env!("DB_PASS"),
  hostname: System.fetch_env!("DB_HOST"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE", "10"))

config :job_hunt, JobHuntWeb.Router,
  port: String.to_integer(System.fetch_env!("PORT"))
