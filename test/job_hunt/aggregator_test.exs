defmodule JobHunt.AggregatorTest do
  use ExUnit.Case, async: true

  alias JobHunt.Aggregator

  test "filters by salary" do
    jobs = [%{salary: 120_000, title: "Elixir Dev"}, %{salary: 90_000}]
    assert [%{salary: 120_000, title: "Elixir Dev"}] = Aggregator.filter(jobs, %{})
  end

  test "rejects when keyword missing" do
    jobs = [%{salary: 120_000, title: "Unrelated"}]
    assert [] = Aggregator.filter(jobs, %{keyword: "Elixir"})
  end
end
