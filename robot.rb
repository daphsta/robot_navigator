require_relative 'point'
require_relative 'navigate_robot'

class Robot
  attr_accessor :current_position, :current_direction, :grid_size, :valid

  NAVIGATION_TYPE = {
    move:  -> (robot) { NavigateRobot.new(robot).move_forward },
    left:  -> (robot) { NavigateRobot.new(robot).rotate_left },
    right: -> (robot) { NavigateRobot.new(robot).rotate_right }
  }

  def initialize(point_x, point_y, current_direction)
    @current_position  = Point.new(point_x, point_y)
    @current_direction = current_direction
    @grid_size         = Point.new(5, 5)
  end

  def run(instruction)
    validate
    if valid?
      NAVIGATION_TYPE[instruction.downcase.to_sym].call(self)
    end
  end

  def report
    puts "Output: #{self.current_position.x}, #{self.current_position.y} #{self.current_direction}"
  end


  private

  def validate
    if (current_position.x > grid_size.x || current_position.y > grid_size.y) || (current_position.x < 0 || current_position.y < 0)
      @valid = false
    else
      @valid = true
    end
  end

  def valid?
    @valid
  end

end