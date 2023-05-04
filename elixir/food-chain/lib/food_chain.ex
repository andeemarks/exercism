defmodule Food do
  defstruct [:food, :description, :subtitle, :preceeds]
end

defmodule FoodChain do
  @chain [
    %Food{
      food: "fly",
      preceeds: "spider",
      subtitle: "I don't know why she swallowed the fly. Perhaps she'll die."
    },
    %Food{
      food: "spider",
      preceeds: "bird",
      description: " that wriggled and jiggled and tickled inside her",
      subtitle: "It wriggled and jiggled and tickled inside her."
    },
    %Food{
      food: "bird",
      preceeds: "cat",
      subtitle: "How absurd to swallow a bird!"
    },
    %Food{
      food: "cat",
      preceeds: "dog",
      subtitle: "Imagine that, to swallow a cat!"
    },
    %Food{
      food: "dog",
      preceeds: "goat",
      subtitle: "What a hog, to swallow a dog!"
    },
    %Food{
      food: "goat",
      preceeds: "cow",
      subtitle: "Just opened her throat and swallowed a goat!"
    },
    %Food{
      food: "cow",
      preceeds: "horse",
      subtitle: "I don't know how she swallowed a cow!"
    },
    %Food{
      food: "horse",
      preceeds: nil,
      subtitle: "She's dead, of course!"
    }
  ]
  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, start) when start in [1, 8] do
    meal = Enum.at(@chain, start - 1)

    """
    I know an old lady who swallowed a #{meal.food}.
    #{meal.subtitle}
    """
  end

  def recite(start, start) do
    meal = Enum.at(@chain, start - 1)

    """
    I know an old lady who swallowed a #{meal.food}.
    #{meal.subtitle}
    #{add(start - 1)}
    """
    |> String.trim_trailing()
    |> Kernel.<>("\n")
  end

  def recite(start, stop) do
    """
    #{recite(start, start)}
    #{recite(start + 1, stop)}
    """
    |> String.trim_trailing()
    |> Kernel.<>("\n")
  end

  defp add(1) do
    meal = Enum.at(@chain, 0)

    """
    She swallowed the #{meal.preceeds} to catch the #{meal.food}.
    #{meal.subtitle}
    """
  end

  defp add(start) do
    meal = Enum.at(@chain, start - 1)

    """
    She swallowed the #{meal.preceeds} to catch the #{meal.food}#{meal.description}.
    #{add(start - 1)}
    """
  end
end
