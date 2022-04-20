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
