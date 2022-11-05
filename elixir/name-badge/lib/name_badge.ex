defmodule NameBadge do
  def print(id, name, department) do
    id = if(is_nil(id), do: "", else: "[#{id}] - ")
    department = if(is_nil(department), do: "owner", else: department)

    "#{id}#{name} - #{String.upcase(department)}"
  end
end
