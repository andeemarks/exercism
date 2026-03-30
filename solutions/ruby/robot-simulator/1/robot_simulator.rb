class Robot
  def initialize()
    
  end

  @@directions = [:north, :east, :south, :west]

  def orient(direction)

    raise ArgumentError if !@@directions.include?(direction)

    @bearing = direction
  end

  def turn_right()
    bearing_index = @@directions.index(@bearing)

    @bearing = @@directions[(bearing_index + 1) % 4]
  end

  def turn_left()
    bearing_index = @@directions.index(@bearing)

    @bearing = @@directions[(bearing_index - 1) % 4]
  end

  def at(x_coord, y_coord)
    @coordinates = [x_coord, y_coord]
  end

  def advance()
    case @bearing
    when :north
      @coordinates = [@coordinates[0], @coordinates[1] + 1]
    when :south
      @coordinates = [@coordinates[0], @coordinates[1] - 1]
    when :east
      @coordinates = [@coordinates[0] + 1, @coordinates[1]]
    when :west
      @coordinates = [@coordinates[0] - 1, @coordinates[1]]
    end
  end

  attr_reader :bearing, :coordinates

end

class Simulator
  def instructions(command_list)
    commands = []
    command_list.each_char do |command|
      case command
      when 'L'
        commands << :turn_left
      when 'R'
        commands << :turn_right
      when 'A'
        commands << :advance
      end
    end

    commands
  end

  def place(robot, x:, y:, direction:)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, command_list)
    commands = instructions(command_list)

    commands.each do |command|
      case command
      when :turn_left
        robot.turn_left()
      when :turn_right
        robot.turn_right
      when :advance
        robot.advance()
      end
    end
  end
end