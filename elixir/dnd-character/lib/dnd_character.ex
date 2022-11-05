defmodule DndCharacter do
  @d6 1..6

  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    round(Float.floor((score - 10) / 2))
  end

  @spec ability :: pos_integer()
  def ability do
    [roll_d6(), roll_d6(), roll_d6(), roll_d6()]
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end

  @spec character :: t()
  def character do
    constitution = ability()
    %{
          strength: ability(),
          dexterity: ability(),
          constitution: constitution,
          intelligence: ability(),
          wisdom: ability(),
          charisma: ability(),
          hitpoints: 10 + modifier(constitution)
        }
  end

  defp roll_d6(), do: Enum.random(@d6)
end
