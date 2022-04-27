# Write a function that returns `true` if a single-quoted
# string contains only printable ASCII characters (space
# through tilde).

defmodule MyString do
  def printable?([]), do: true
  def printable?([ char | tail ]) do
    if String.printable?(to_string [ char ]) do
      MyString.printable?(tail)
    else
      false
    end
  end
end
