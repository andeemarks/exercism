defmodule RobotSimulator do
  @type robot() :: any()
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, {x, y} = position)
      when direction in [:north, :east, :south, :west] and is_integer(x) and is_integer(y) do
    {direction, position}
  end

  def create(_, {x, y}) when is_integer(x) and is_integer(y), do: {:error, "invalid direction"}

  def create(_, _), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) ::
          robot() | {:error, String.t()}
  def simulate({direction, position}, "R") do
    case direction do
      :north -> {:east, position}
      :east -> {:south, position}
      :south -> {:west, position}
      :west -> {:north, position}
    end
  end

  def simulate({direction, position}, "L") do
    case direction do
      :north -> {:west, position}
      :east -> {:north, position}
      :south -> {:east, position}
      :west -> {:south, position}
    end
  end

  def simulate({direction, {x, y}}, "A") do
    case direction do
      :north -> {:north, {x, y + 1}}
      :east -> {:east, {x + 1, y}}
      :south -> {:south, {x, y - 1}}
      :west -> {:west, {x - 1, y}}
    end
  end

  def simulate(robot, []), do: robot

  def simulate(robot, [first_instruction | rest]) do
    robot = simulate(robot, first_instruction)
    simulate(robot, rest)
  end

  def simulate(robot, instructions) do
    instruction_list = String.codepoints(instructions)

    if Enum.any?(instruction_list, fn instruction -> instruction not in ["A", "L", "R"] end) do
      {:error, "invalid instruction"}
    else
      simulate(robot, instruction_list)
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction({direction, _}) do
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position({_, position}) do
    position
  end
end
