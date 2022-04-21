# Programming Elixir 1.6
# Modules

# Extend the Times module with a triple function that
# multiplies it's parameter by 3

# Add a cruaduple function. Maybe it could call the double
# function

defmodule Times do
  def double (n) do
    n * 2
  end

  def triple (n) do
    n * 3
  end

  def cruaduple (n) do
    Times.double(n) * Times.double(n)
  end
end

# Implement a function sum(n) that uses recursion to
# calculate the sum of the integers from 1 to n.

defmodule RecursiveSum do
  def sum(1) do
    1
  end

  def sum(n) do
    n + RecursiveSum.sum(n - 1)
  end
end

# Write a function gcd(x, y) that finds the greatest
# common divisor between two nonnegative integers.
# Algebraically, gcd(x, y) is x if y is zero; it's
# gcd(y, rem(x, y)) otherwise.

defmodule RecursiveGCD do
  def gcd(x, 0) do
    x
  end

  def gcd(x, y) do
    RecursiveGCD.gcd(y, rem(x, y))
  end
end

# I’m thinking of a number between 1 and 1000.…

# The most efficient way to find the number is to
# guess halfway between the low and high numbers of
# the range. If our guess is too big, then the answer
# lies between the bottom of the range and one less
# than our guess. If our guess is too small, then the
# answer lies between one more than our guess and the
# end of the range.

# Your API will be guess(actual, range), where range
# is an Elixir range. Your output should look similar
# to this:

# iex> Chop.guess(273, 1..1000)
# Is it 500?
# Is it 250?
# Is it 375?
# Is it 312?
# Is it 281?
# Is it 265?
# Is it 273?
# 273!

defmodule Chop.Printer do
  def print(:guess, value), do: IO.puts "Is it #{value}?"
  def print(:actual, value), do: IO.puts "#{value}!"
end

defmodule Chop.Utils do
  def get_middle(min, max), do: div(min + max, 2)
end

defmodule Chop do
  def guess(actual, min..max) when div(min + max, 2) > actual do
    Chop.Printer.print(:guess, Chop.Utils.get_middle(min, max))
    Chop.guess(actual, min..Chop.Utils.get_middle(min, max))
  end

  def guess(actual, min..max) when div(min + max, 2) < actual do
    Chop.Printer.print(:guess, Chop.Utils.get_middle(min, max))
    Chop.guess(actual, Chop.Utils.get_middle(min, max)..max)
  end

  def guess(_actual, min..max), do: Chop.Printer.print(:actual, Chop.Utils.get_middle(min, max))
end
