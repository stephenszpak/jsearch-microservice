defmodule JobHunt.Sources.GitHub do
  @behaviour JobHunt.Sources

  @impl true
  def fetch(query) do
    job = %{
      job_id: "gh_1",
      title: "Elixir Developer",
      company: "GitHub",
      location: "Remote",
      salary: "$120000",
      remote: true,
      url: "https://example.com/jobs/gh_1",
      description: "Work on open source projects"
    }

    keyword = String.downcase(to_string(query[:keyword] || ""))

    if String.contains?(String.downcase(job.title), keyword) do
      [job]
    else
      []
    end
  end
end
