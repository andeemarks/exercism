defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:battery_percentage, :distance_driven_in_meters, :nickname]

  def new(nickname \\ "none") do
    %RemoteControlCar{battery_percentage: 100, distance_driven_in_meters: 0, nickname: nickname}
  end

  def display_distance(%RemoteControlCar{} = remote_car) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{
        battery_percentage: 0,
        distance_driven_in_meters: _,
        nickname: _
      }) do
    "Battery empty"
  end

  def display_battery(%RemoteControlCar{
        battery_percentage: battery_percentage,
        distance_driven_in_meters: _,
        nickname: _
      }) do
    "Battery at #{battery_percentage}%"
  end

  def drive(%RemoteControlCar{
        battery_percentage: 0,
        distance_driven_in_meters: _,
        nickname: _
      }) do
    %{RemoteControlCar.new() | battery_percentage: 0}
  end

  def drive(%RemoteControlCar{} = remote_car) do
    %{
      remote_car
      | battery_percentage: remote_car.battery_percentage - 1,
        distance_driven_in_meters: remote_car.distance_driven_in_meters + 20
    }
  end
end
