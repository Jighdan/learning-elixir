defmodule Issues.GithubIssues.DataProcess do
  def sort_into_descending_order(list_of_issues) do
    list_of_issues |> Enum.sort(&(&1["created_at"] >= &2["created_at"]))
  end

  def take(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse()
  end
end
