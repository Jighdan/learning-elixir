# Implement the following Enum functions using no library functions
# or list comprehensions: all?, each, filter, split, and take. You
# may need to use an if statement to implement the filter

defmodule MyEnum do
  def all?([], _fun), do: true
  def all?([head | tail], fun) do
    if fun.(head), do: all?(tail, fun), else: false
  end

  def each([], _function), do: {:ok}
  def each([head | tail], function) do
    function.(head)
    MyEnum.each(tail, function)
  end

  def filter([], _fun), do: []
  def filter([head | tail], fun) do
    if fun.(head) do
      [ head | filter(tail, fun)]
    else
      filter(tail, fun)
    end
  end

  def reverse([]), do: []
  def reverse([ head | tail ]), do: MyEnum.reverse((tail) ++ [head])

  def split(list, n) when n >= 0, do: do_split(list, n, [])
  def split(list, n) when n < 0, do: do_split(list, n + length(list), [])
  defp do_split([ head | tail ], n, result) when length(result) < n do
    do_split(tail, n, result ++ [head])
  end
  defp do_split(list, _n, result), do: { result, list }

  def take(list, n) when n >= 0, do: do_take(list, n, [])
  def take(list, n) when n < 0 do
    index = abs(n)

    list |> MyEnum.reverse() |> do_take(index, []) |> MyEnum.reverse()
  end

  defp do_take([ head | tail], n, result) when length(result) < n do
    do_take(tail, n, result ++ [head])
  end
  defp do_take(_list, _n, result), do: result
end

# Write a flatten(list) that takes a list that may contain any number
# of sublists, which themselves may contain sublists, to any depth.
# It returns the elements of these lists as a flat list.

defmodule MyList1 do
  def flatten([]), do: []
  def flatten([head | tail]) when is_list(head) do
    MyList1.flatten(head) ++ MyList1.flatten(tail)
  end
  def flatten([head | tail]), do: [head] ++ MyList1.flatten(tail)
end

# Use the span function and list comprehension to return a list
# of the prime numbers from 2 to n

defmodule MyList2 do
  def get_prime_numbers_from(n) when n > 2 do
    for x <- MyList2.span(2, n), rem(x, 2) != 0, do: x
  end

  def span(from, to) when is_integer(from) and is_integer(to) and from < to do
    Range.new(from, to) |> Enum.to_list()
  end
end

# The Pragmatic Bookshelf has offices in Texas (TX) and North
# Carolina (NC), so we have to charge sales tax on orders shipped
# to these states. The rates can be expressed as a keyword list:

tax_rates = [ NC: 0.075, TX: 0.08 ]

# Here's a list of orders:

orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  [ id: 124, ship_to: :OK, net_amount: 35.50 ],
  [ id: 125, ship_to: :TX, net_amount: 24.00 ],
  [ id: 126, ship_to: :TX, net_amount: 44.80 ],
  [ id: 127, ship_to: :NC, net_amount: 25.00 ],
  [ id: 128, ship_to: :MA, net_amount: 10.00 ],
  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  [ id: 130, ship_to: :NC, net_amount: 50.00 ]
]

# Write a function that takes both lists and returns a copy of the
# orders, but with an extra field, total_amount, which is the net plus
# sales tax. If a shipment is not to NC or TX, there's no tax applied.

defmodule TaxAdder do
  def add() do
    TaxAdder.orders |> Enum.map(&(generate_total_amount_field(TaxAdder.tax_rates, &1)))
  end

  defp generate_total_amount_field(tax_rates, [id: _id, ship_to: ship_to, net_amount: net_amount] = order) do
    total_amount = case Keyword.has_key?(tax_rates, ship_to) do
      true -> add_tax(net_amount, tax_rates[ship_to])
      _ -> net_amount
    end

    put_in(order, [:total_amount], total_amount)
  end

  defp add_tax(amount, tax), do: amount + tax |> Float.ceil(2)

  def tax_rates, do: [ NC: 0.075, TX: 0.08 ]
  def orders, do: [
    [ id: 123, ship_to: :NC, net_amount: 100.00 ],
    [ id: 124, ship_to: :OK, net_amount: 35.50 ],
    [ id: 125, ship_to: :TX, net_amount: 24.00 ],
    [ id: 126, ship_to: :TX, net_amount: 44.80 ],
    [ id: 127, ship_to: :NC, net_amount: 25.00 ],
    [ id: 128, ship_to: :MA, net_amount: 10.00 ],
    [ id: 129, ship_to: :CA, net_amount: 102.00 ],
    [ id: 130, ship_to: :NC, net_amount: 50.00 ]
  ]
end
