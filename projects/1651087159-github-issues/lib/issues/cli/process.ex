defmodule Issues.CLI.Process do
  alias Issues.GithubIssues
  alias Issues.CLI.Decoder

  def process(:help) do
    IO.puts("""
    usage:
      issues <user> <project> <count>
    """)

    System.halt()
  end

  def process({user, project, _count}) do
    GithubIssues.fetch(user, project)
    |> Decoder.decode_response()
  end
end
