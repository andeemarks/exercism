defmodule FileSniffer do
  def type_from_extension(extension) do
    %{"bmp" => "image/bmp", "gif" => "image/gif", "jpg" => "image/jpg", "png" => "image/png", "exe" => "application/octet-stream"}
    |> Map.fetch(extension)
    |> elem(1)
  end

  defp check_header(<<0x7f, 0x45, 0x4c, 0x46, _::binary>>), do: type_from_extension("exe")
  defp check_header(<<0x42, 0x4d, _::binary>>), do: type_from_extension("bmp")
  defp check_header(<<0xff, 0xd8, 0xff, _::binary>>), do: type_from_extension("jpg")
  defp check_header(<<0x47, 0x49, 0x46, _::binary>>), do: type_from_extension("gif")
  defp check_header(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>), do: type_from_extension("png")

  def type_from_binary(<<header::binary-size(8), _::binary>>) do
    check_header(header)
  end

  defp verify_types(header_type, binary_type) when header_type == binary_type do
    {:ok, header_type}
  end

  defp verify_types(_, _) do
    {:error, "Warning, file format and file extension do not match."}
  end

  def verify(file_binary, extension) do
    type_from_extension = type_from_extension(extension)
    type_from_binary = type_from_binary(file_binary)

    verify_types(type_from_extension, type_from_binary)
  end
end
