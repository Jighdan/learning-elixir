# Programming Elixir 1.6
# Functions

# Write a function that takes three arguments. If the first
# two are zero, return "FizzBuzz". If the first is zero,
# return "Fizz". If the second is zero, return "Buzz".
# Otherwise return the third argument.

fizz_buzz_base = fn a, b, c ->
  cond do
    a === 0 and b === 0 ->
      "FizzBuzz"
    a === 0 ->
      "Fizz"
    b === 0 ->
      "Buzz"
    true ->
      c
  end
end

# The operator rem(a, b) returns the remainder after dividing
# a by b. Write a function that takes a single integer (n)
# and calls the function in the previous exercise, passing
# it: rem(n, 3), rem(n, 5), n. Call it seven times with
# the arguments 10, 11, 12, and so on. You should get "Buzz",
# 11, "Fizz", 13, 14, "FizzBuzz", 16.

fizz_buzz = fn n ->
  fizz_buzz_base.(rem(n, 3), rem(n, 5), n)
end

Range.new(10, 16)
  |> Enum.map(&fizz_buzz.(&1))
  |> Enum.join(", ")
  |> IO.puts

# Write a function prefix that takes a string. It should
# return a new function that takes a second string. When that
# second function is called, it will return a string
# containing the first string, a space, and the second string.

prefix = fn first_string ->
  fn second_string ->
    "#{first_string} #{second_string}"
  end
end

prefix.("Elixir").("Rocks") |> IO.puts
prefix.("Mrs.").("Smith") |> IO.puts

# Use the & notation to rewrite the following
Enum.map [ 1, 2, 3, 4 ], fn x -> x + 2 end
[ 1, 2, 3, 4 ] |> Enum.map(&(&1 + 2))

Enum.each [ 1, 2, 3, 4 ], fn x -> IO.inspect(x) end
[ 1, 2, 3, 4 ] |> Enum.each(&(IO.inspect(&1)))
