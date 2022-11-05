# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(_opts \\ []) do
    Agent.start(fn -> [] end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn registrations -> registrations end)
  end

  def register(pid, register_to) do
    plot = %Plot{plot_id: Time.utc_now().microsecond, registered_to: register_to}
    Agent.update(pid, fn registrations -> [plot | registrations] end)

    plot
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn registrations -> Enum.filter(registrations, fn rego -> rego.plot_id != plot_id end) end)
  end

  defp find_registration_for_plot([]), do: {:not_found, "plot is unregistered"}
  defp find_registration_for_plot(registrations), do: hd(registrations)

  def get_registration(pid, plot_id) do
    registrations = Agent.get(pid, fn registrations -> Enum.filter(registrations, fn rego -> rego.plot_id == plot_id end) end)
    find_registration_for_plot(registrations)
  end
end
