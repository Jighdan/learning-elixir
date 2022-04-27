defmodule Issues.GithubIssues.DataProcessTest do
  use ExUnit.Case
  doctest Issues

  alias Issues.GithubIssues.DataProcess

  describe "sort_into_descending_order/1" do
    test "sorts the correct way" do
      list = fake_created_at_list(["c", "a", "b"])
      result = DataProcess.sort_into_descending_order(list)
      issues = for issue <- result, do: Map.get(issue, "created_at")

      assert issues == ~w{ c b a }
    end

    defp fake_created_at_list(values) do
      values |> Enum.map(&%{"created_at" => &1, "other_data" => "klk"})
    end
  end
end
