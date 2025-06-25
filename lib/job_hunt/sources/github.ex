defmodule JobHunt.Sources.GitHub do
  @behaviour JobHunt.Sources

  @impl true
  def fetch(_query) do
    []
  end
end
