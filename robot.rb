require_relative 'point'
require_relative 'navigate_robot'

class Robot
  attr_accessor :current_position, :current_direction, :grid_size

  NAVIGATION_TYPE = {
    move:  -> (robot) { NavigateRobot.new(robot).move_forward },
    left:  -> (robot) { NavigateRobot.new(robot).rotate_left },
    right: -> (robot) { NavigateRobot.new(robot).rotate_right }
  }

  def initialize
    @grid_size = Point.new(5, 5)
  end


  def place(*args)
    self.current_position   = Point.new

    coordinate              = args[0].split(',')
    self.current_position.x = coordinate[0].to_i
    self.current_position.y = coordinate[1].to_i
    self.current_direction  = coordinate[2]
  end

  def move(*args)
    validate
    NAVIGATION_TYPE[:move].call(self) if valid?
  end

  def left(*args)
    validate
    NAVIGATION_TYPE[:left].call(self) if valid?
  end

  def right(*args)
    validate
    NAVIGATION_TYPE[:right].call(self) if valid?
  end

  def method_missing *args
    puts 'method missing'
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