class NavigateRobot
  attr_reader :robot

  def initialize(robot)
    @robot = robot
  end

  #compass object
  #data structure
  #array of directions
  def rotate_right
    case robot.current_direction
      when "NORTH"
        robot.current_direction = "EAST"
      when "SOUTH"
        robot.current_direction = "WEST"
      when "EAST"
        robot.current_direction = "SOUTH"
      when "WEST"
        robot.current_direction = "NORTH"
    end
  end

  def rotate_left
    case robot.current_direction
      when "NORTH"
        robot.current_direction = "WEST"
      when "SOUTH"
        robot.current_direction = "EAST"
      when "EAST"
        robot.current_direction = "NORTH"
      when "WEST"
        robot.current_direction = "SOUTH"
    end
  end

  def move_forward
    case robot.current_direction
      when "NORTH"
        increment_y
      when "SOUTH"
        decrement_y
      when "EAST"
        increment_x
      when "WEST"
        decrement_x
    end
  end

  private
  def increment_y
    if robot.current_position.y < robot.grid_size.y
      robot.current_position.y += 1
    else
      robot.current_position
    end
  end

  def decrement_y
    if (robot.current_position.y < robot.grid_size.y) && robot.current_position.y > 0
      robot.current_position.y -= 1
    else
      robot.current_position
    end
  end

  def increment_x
    if robot.current_position.x < robot.grid_size.x
      robot.current_position.x += 1
    else
      robot.current_position
    end
  end

  def decrement_x
    if (robot.current_position.x < robot.grid_size.x) && robot.current_position.x >0
      robot.current_position.x -= 1
    else
      robot.current_position
    end
  end
end