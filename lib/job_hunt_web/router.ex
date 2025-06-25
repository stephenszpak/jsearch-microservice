defmodule JobHuntWeb.Router do
  use Plug.Router
  use PromEx.Plug, prom_ex_module: JobHunt.PromEx

  plug :match
  plug :dispatch

  get "/health" do
    send_resp(conn, 200, "OK")
  end

  get "/jobs" do
    keyword = get_in(conn.params, ["keyword"]) || ""
    remote_only = conn.params["remote_only"] == "true"
    jobs = JobHunt.Aggregator.fetch_all(%{keyword: keyword, remote_only: remote_only})
    send_resp(conn, 200, Jason.encode!(jobs))
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
