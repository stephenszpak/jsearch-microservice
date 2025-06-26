defmodule JobHunt.Sources.GitHubTest do
  use ExUnit.Case, async: true

  alias JobHunt.Sources.GitHub

  test "fetch returns a matching job" do
    [%{title: title}] = GitHub.fetch(%{keyword: "elixir"})
    assert String.contains?(String.downcase(title), "elixir")
  end
end
