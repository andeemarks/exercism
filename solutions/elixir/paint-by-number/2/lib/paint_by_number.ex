defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    palette_bit_size(color_count, 1)
  end

  defp palette_bit_size(color_count, size) do
    if 2 ** size >= color_count do
      size
    else
      palette_bit_size(color_count, size + 1)
    end
  end

  def empty_picture(), do: <<>>

  def test_picture(), do: <<0::2, 1::2, 2::2, 3::2>>

  def prepend_pixel(picture, color_count, pixel_color_index) do
    << pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring >>
  end

  def get_first_pixel(<<>>, _), do: nil
  def get_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    << value::size(bit_size), _::bitstring >> = picture

    value
  end

  def drop_first_pixel(<<>>, _), do: <<>>
  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    << _::size(bit_size), rest::bitstring >> = picture

    rest
  end

  def concat_pictures(picture1, picture2) do
    << picture1::bitstring, picture2::bitstring>>
  end
end
