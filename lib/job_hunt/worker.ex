defmodule JobHunt.Worker do
  use GenServer
  require Logger

  alias JobHunt.Aggregator
  alias JobHunt.Repo
  alias JobHunt.Jobs.Job

  @refresh_intervals %{
    linkedin: 21_600,
    indeed: 21_600,
    glassdoor: 86_400,
    github: 86_400
  }

  def start_link(source) do
    GenServer.start_link(__MODULE__, source, name: via_tuple(source))
  end

  def via_tuple(source) do
    {:via, Registry, {JobHunt.WorkerRegistry, source}}
  end

  @impl true
  def init(source) do
    schedule_work(source)
    {:ok, source}
  end

  @impl true
  def handle_info(:work, source) do
    Logger.info("fetching #{source}")
    Aggregator.fetch_all(%{source: source})
    schedule_work(source)
    {:noreply, source}
  end

  defp schedule_work(source) do
    interval = Map.get(@refresh_intervals, source, 86_400)
    Process.send_after(self(), :work, interval * 1000)
  end
end
