defmodule Issues.CLI.TableFormatter do
  def print(rows, headers) do
    with data_by_columns = split_into_columns(rows, headers),
         column_widths = widths_of(data_by_columns),
         format = format_for(column_widths) do
      puts_one_line_in_columns(headers, format)
      IO.puts(separator(column_widths))
      puts_in_columns(data_by_columns, format)
    end
  end

  defp split_into_columns(rows, headers) do
    for header <- headers do
      for row <- rows, do: printable(row[header])
    end
  end

  defp printable(str) when is_binary(str), do: str
  defp printable(str), do: to_string(str)

  defp widths_of(columns) do
    for column <- columns, do: column |> Enum.map(&String.length/1) |> Enum.max()
  end

  defp format_for(column_widths) do
    Enum.map_join(column_widths, "-+-", &List.duplicate("-", &1))
  end

  defp separator(column_widths) do
    Enum.map_join(column_widths, "-+-", &List.duplicate("-", &1))
  end

  defp puts_in_columns(data_by_columns, format) do
    data_by_columns
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.each(&puts_one_line_in_columns(&1, format))
  end

  defp puts_one_line_in_columns(fields, format) do
    :io.format(format, fields)
  end
end
