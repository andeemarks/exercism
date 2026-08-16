defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """

  @ordinals [
    ["first", "a Partridge in a Pear Tree"],
    ["second", "two Turtle Doves"],
    ["third", "three French Hens"],
    ["fourth", "four Calling Birds"],
    ["fifth", "five Gold Rings"],
    ["sixth", "six Geese-a-Laying"],
    ["seventh", "seven Swans-a-Swimming"],
    ["eighth", "eight Maids-a-Milking"],
    ["ninth", "nine Ladies Dancing"],
    ["tenth", "ten Lords-a-Leaping"],
    ["eleventh", "eleven Pipers Piping"],
    ["twelfth", "twelve Drummers Drumming"]
  ]

  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    ordinal = Enum.at(@ordinals, number - 1) |> Enum.at(0)
    gifts = build_gifts(number)
    "On the #{ordinal} day of Christmas my true love gave to me: #{gifts}."
  end

  defp build_gifts(1) do
    Enum.at(@ordinals, 0) |> Enum.at(1)
  end

  defp build_gifts(number) do
    Enum.reduce((number - 1)..0//-1, "", fn i, acc ->
      gift = Enum.at(@ordinals, i) |> Enum.at(1)
      if i == 0 do
        acc <> "and " <> build_gifts(1)
      else
        acc <> gift <> ", "
      end
    end)
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    Enum.reduce(starting_verse..ending_verse, "", fn i, acc ->
      verse = verse(i)
      if acc == "" do
        verse
      else
        acc <> "\n" <> verse
      end
    end)
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    TwelveDays.verses(1, 12)
  end
end
