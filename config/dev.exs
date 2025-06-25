import Config

config :job_hunt, JobHunt.Repo,
  database: "job_hunt_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :job_hunt, JobHuntWeb.Router, port: 4000
