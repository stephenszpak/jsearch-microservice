defmodule JobHunt.MixProject do
  use Mix.Project

  def project do
    [
      app: :job_hunt,
      version: "0.1.0",
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {JobHunt.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:tesla, "~> 1.7"},
      {:finch, "~> 0.17"},
      {:floki, "~> 0.36"},
      {:broadway, "~> 1.0"},
      {:ecto_sql, "~> 3.11"},
      {:postgrex, ">= 0.0.0"},
      {:plug_cowboy, "~> 2.6"},
      {:jason, "~> 1.4"},
      {:quantum, "~> 3.0"},
      {:logger_json, "~> 5.0"},
      {:prom_ex, "~> 1.9"},
      {:mox, "~> 1.0", only: :test},
      {:dotenvy, "~> 0.8"}
    ]
  end
end
