defmodule Issues.CLI.Process do
  alias Issues.GithubIssues
  alias Issues.GithubIssues.DataProcess
  alias Issues.CLI.Decoder
  alias Issues.CLI.TableFormatter, as: TF

  def process(:help) do
    IO.puts("""
    usage:
      issues <user> <project> <count>
    """)

    System.halt()
  end

  def process({user, project, count}) do
    GithubIssues.fetch(user, project)
    |> Decoder.decode_response()
    |> DataProcess.sort_into_descending_order()
    |> DataProcess.take(count)
    |> TF.print(["number", "created_at", "title"])
  end
end
