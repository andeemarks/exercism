defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @earth_years 60 * 60 * 24 * 365.25

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) do
    case planet do
      :earth -> {:ok, earth_age(seconds)}
      :mercury -> {:ok, earth_age(seconds) / 0.2408467}
      :venus -> {:ok, earth_age(seconds) / 0.61519726}
      :mars -> {:ok, earth_age(seconds) / 1.8808158}
      :jupiter -> {:ok, earth_age(seconds) / 11.862615}
      :saturn -> {:ok, earth_age(seconds) / 29.447498}
      :uranus -> {:ok, earth_age(seconds) / 84.016846}
      :neptune -> {:ok, earth_age(seconds) / 164.79132}
      _ -> {:error, "not a planet"}
    end
  end

  defp earth_age(seconds), do: seconds / @earth_years
end
