require_relative 'point'

class Robot
  attr_reader :current_position, :current_direction, :grid_size, :valid

  def initialize(point_x, point_y, current_direction)
    @current_position = Point.new(point_x, point_y)
    @current_direction = current_direction
    @grid_size = Point.new(5, 5)
    @valid = true
  end

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

  def rotate_right
    case current_direction
      when "NORTH"
        @current_direction = "EAST"
      when "SOUTH"
        @current_direction = "WEST"
      when "EAST"
        @current_direction = "SOUTH"
      when "WEST"
        @current_direction = "NORTH"
    end
  end

  def rotate_left
    case current_direction
      when "NORTH"
        @current_direction = "WEST"
      when "SOUTH"
        @current_direction = "EAST"
      when "EAST"
        @current_direction = "NORTH"
      when "WEST"
        @current_direction = "SOUTH"
    end
  end

  def move_forward
    case current_direction
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
    if current_position.y < grid_size.y
      @current_position.y += 1
    else
      @current_position
    end
  end

  def decrement_y
    if (current_position.y < grid_size.y) && current_position.y > 0
      @current_position.y -= 1
    else
      @current_position
    end
  end

  def increment_x
    if current_position.x < grid_size.x
      @current_position.x += 1
    else
      @current_position
    end
  end

  def decrement_x
    if (current_position.x < grid_size.x) && current_position.x >0
      @current_position.x -= 1
    else
      @current_position
    end
  end

end