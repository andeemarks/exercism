class Robot
  DIRECTIONS = [:north, :east, :south, :west].freeze

  attr_reader :bearing, :coordinates

  def orient(direction)
    raise ArgumentError unless DIRECTIONS.include?(direction)
    @bearing = direction
  end

  def turn_right
    turn(+1)
  end

  def turn_left
    turn(-1)
  end

  def at(x_coord, y_coord)
    @coordinates = [x_coord, y_coord]
  end

  def advance
    case @bearing
    when :north then @coordinates[1] += 1
    when :south then @coordinates[1] -= 1
    when :east  then @coordinates[0] += 1
    when :west  then @coordinates[0] -= 1
    end
  end

  private

  def turn(step)
    @bearing = DIRECTIONS[(DIRECTIONS.index(@bearing) + step) % 4]
  end
end

class Simulator
  COMMANDS = { 'L' => :turn_left, 'R' => :turn_right, 'A' => :advance }.freeze

  def instructions(command_list)
    command_list.each_char.filter_map { |c| COMMANDS[c] }
  end

  def place(robot, x:, y:, direction:)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, command_list)
    instructions(command_list).each { |command| robot.public_send(command) }
  end
end
