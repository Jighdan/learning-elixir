defmodule Issues.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  tale of the last _n_ issues in a GitHub project
  """

  alias Issues.CLI.ArgsParser
  alias Issues.CLI.Process

  def main(argv) do
    argv |> ArgsParser.parse() |> Process.process()
  end
end
