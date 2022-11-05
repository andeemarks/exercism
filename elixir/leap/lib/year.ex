defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    if Integer.mod(year, 100) == 0 and Integer.mod(year, 400) != 0 do
      false
    else
      Integer.mod(year, 4) == 0
    end
  end
end
