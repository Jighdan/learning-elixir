defmodule Issues.CLI.ArgsParserTest do
  use ExUnit.Case
  doctest Issues

  alias Issues.CLI.ArgsParser

  test ":help returned by option parsing with -h and --help options" do
    assert ArgsParser.parse(["-h", "anything"]) == :help
    assert ArgsParser.parse(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert ArgsParser.parse(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "count is defaulted if two values given" do
    assert ArgsParser.parse(["user", "project"]) == {"user", "project", 4}
  end
end
