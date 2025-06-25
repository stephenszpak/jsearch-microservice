defmodule JobHunt.Aggregator do
  @moduledoc """
  Fetches jobs from multiple sources and filters them.
  """

  @behaviour JobHunt.Sources
  alias JobHunt.Sources

  @keywords ["Web Developer", "Software Engineer", "Elixir", "Ruby", "React", "Angular", "JavaScript", "CSS", "GitHub", "AI"]
  @nashville {36.1627, -86.7816}
  @radius_mi 50

  @sources [
    JobHunt.Sources.LinkedIn,
    JobHunt.Sources.Indeed,
    JobHunt.Sources.Glassdoor,
    JobHunt.Sources.GitHub
  ]

  def fetch_all(query) do
    @sources
    |> Enum.flat_map(fn source ->
      with {:module, _} <- Code.ensure_loaded(source) do
        source.fetch(query)
      else
        _ -> []
      end
    end)
    |> filter(query)
  end

  def filter(raw_jobs, query) do
    raw_jobs
    |> Enum.map(&normalise/1)
    |> Enum.filter(&meets_constraints?(&1, query))
  end

  defp normalise(job) do
    job
    |> Map.update(:salary, nil, &parse_salary/1)
    |> Map.update(:remote, false, &(&1 in [true, "true", "yes"]))
    |> Map.update(:location, nil, &geocode/1)
  end

  defp parse_salary(nil), do: nil
  defp parse_salary(s) when is_binary(s) do
    s
    |> String.replace(~r/[^\d]/, "")
    |> case do
      <<>> -> nil
      digits -> String.to_integer(digits)
    end
  end

  defp geocode(location) when is_binary(location), do: location
  defp geocode(loc), do: loc

  defp meets_constraints?(job, query) do
    salary_ok?(job.salary) and
      remote_or_within_radius?(job.remote, job.location) and
      keyword_ok?(job.title, query[:keyword])
  end

  defp salary_ok?(salary), do: salary && salary >= 110_000

  defp remote_or_within_radius?(true, _loc), do: true
  defp remote_or_within_radius?(_, nil), do: false
  defp remote_or_within_radius?(_, _loc), do: true

  defp keyword_ok?(title, nil), do: keyword_ok?(title, "")
  defp keyword_ok?(title, kw) do
    text = String.downcase(title <> " " <> kw)
    Enum.any?(@keywords, fn word -> String.contains?(text, String.downcase(word)) end)
  end
end
