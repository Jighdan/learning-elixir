# Write a mapsum function that takes a list and a function. It
# applies the function to each element of the list and then
# sums the result, so:

# iex> MyList.mapsum [1, 2, 3], &(&1 * &1)
# 14

defmodule MyList1 do
  def mapsum(list, func) do
    list |> MyList1.map(func) |> MyList1.reduce(0, &(&1 + &2))
  end

  def reduce([], value, _), do: value
  def reduce([ head | tail ], value, func) do
    MyList1.reduce(tail, func.(head, value), func)
  end

  def map([], _fun), do: []
  def map([ head | tail ], func) do
    [ func.(head) | MyList1.map(tail, func) ]
  end
end

# Write a max(list) that returns the element with the maximum
# value in the list. (This is slightly trickier than it sounds.)

defmodule MyList2 do
  def get_max([], highest), do: highest
  def get_max( [ head | tail ], highest) when head > highest do
    get_max(tail, highest)
  end
  def get_max([_head | tail ], highest), do: get_max(tail, highest)
end

# Write a function MyList.span(from, to) that returns a list of
# the numbers from from up to to.

defmodule MyList3 do
  def span(from, to) when is_integer(from) and is_integer(to) and from < to do
    Range.new(from, to) |> Enum.to_list()
  end
end
