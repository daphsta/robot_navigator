require_relative 'point'

class Robot
  attr_accessor :current_position, :current_direction
  attr_reader :valid, :grid_x, :grid_y

  COMPASS = ["NORTH", "EAST", "SOUTH", "WEST"]

  MOVE = {
    north: -> (robot) { robot.send(:increment_y) },
    south: -> (robot) { robot.send(:decrement_y) },
    east:  -> (robot) { robot.send(:increment_x) },
    west:  -> (robot) { robot.send(:decrement_x) }
  }

  def initialize(grid_x,grid_y)
    @grid_x      = grid_x
    @grid_y      = grid_y
    @gridx_array = Array.new(grid_x) { |i| i }
    @gridy_array = Array.new(grid_y) { |i| i }
  end


  def place(args)
    self.current_position   = Point.new
    coordinate              = args.split(',')

    self.current_position.x = coordinate[0].to_i
    self.current_position.y = coordinate[1].to_i
    self.current_direction  = coordinate[2]
  end

  def move(*args)
    validate
    MOVE[self.current_direction.downcase.to_sym].call(self) if valid?
  end

  def left(*args)
    rotate_left
  end

  def right(*args)
    rotate_right
  end

  def method_missing(*args)
    puts 'Invalid instruction'
  end

  def report(*args)
    validate
    puts "Output: #{self.current_position.x}, #{self.current_position.y} #{self.current_direction}" if valid?
    puts 'Invalid position' unless valid?
  end


  private

  def validate
    @valid = false
    return @valid = false if current_direction.nil?
    return @valid = true if (@gridy_array.include?(current_position.y) && @gridx_array.include?(current_position.x))
  end

  def valid?
    @valid
  end

  def rotate_left
    COMPASS.each_with_index do |direction, index|
      if self.current_direction == direction
        COMPASS.rotate!(-1)
        return self.current_direction = COMPASS[index]
      end
    end
  end

  def rotate_right
    COMPASS.each_with_index do |direction, index|
      if self.current_direction == direction
        COMPASS.rotate!(1)
        return self.current_direction = COMPASS[index]
      end
    end
  end

  def increment_y
    @gridy_array.each do |point|
      if (self.current_position.y + 1) == point
        return self.current_position.y += 1
      end
    end
  end

  def decrement_y
    @gridy_array.each do |point|
      if (self.current_position.y - 1) == point
        return self.current_position.y -= 1
      end
    end
  end

  def increment_x
    @gridx_array.each do |point|
      if (self.current_position.x + 1) == point
        return self.current_position.x += 1
      end
    end
  end

  def decrement_x
    @gridx_array.each do |point|
      if (self.current_position.x - 1) == point
        return self.current_position.x -= 1
      end
    end
  end
end