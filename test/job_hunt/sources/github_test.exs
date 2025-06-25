defmodule JobHunt.Sources.GitHubTest do
  use ExUnit.Case, async: true

  alias JobHunt.Sources.GitHub

  test "fetch returns empty list" do
    assert [] = GitHub.fetch(%{})
  end
end
