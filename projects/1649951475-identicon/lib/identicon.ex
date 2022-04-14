defmodule Identicon do
  def main(input) do
    input
    |> Identicon.hash_string()
    |> Identicon.pick_color()
    |> Identicon.Image.Grid.build_grid()
    |> Identicon.Image.Grid.filter_odd_squares()
    |> Identicon.build_pixel_grid()
    |> Identicon.draw_image
    |> Identicon.save_image(input)
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image_size = 250
    image = :egd.create(image_size, image_size)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end)

    :egd.render(image)
  end

  def build_pixel_grid(%Identicon.Image{grid: grid} = image) do
    pixel_size = 50
    grids_per_row = 5

    pixel_map =
      grid
      |> Enum.map(fn {_code, index} ->
        horizontal = rem(index, grids_per_row) * pixel_size
        vertical = div(index, grids_per_row) * pixel_size

        top_left = {horizontal, vertical}
        bottom_right = {horizontal + pixel_size, vertical + pixel_size}
        {top_left, bottom_right}
      end)

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def pick_color(%Identicon.Image{hex: [red, green, blue | _tail]} = image) do
    %Identicon.Image{image | color: {red, green, blue}}
  end

  def hash_string(input) do
    hex = :crypto.hash(:md5, input) |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end
end
