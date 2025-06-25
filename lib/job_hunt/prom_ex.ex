defmodule JobHunt.PromEx do
  use PromEx, otp_app: :job_hunt

  @impl true
def plugins, do: []

  @impl true
def dashboards, do: []
end
