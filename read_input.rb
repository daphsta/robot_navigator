require_relative 'robot'

class ReadInput
  class << self
    def instruction_from_file
      begin
        file = File.new("input.txt", "r")

        while (instruction = file.gets)
          if instruction.include?("PLACE")
            robot = robot_position(instruction)
            break
          end
        end

        unless robot.nil?
          while (instruction = file.gets)
            if instruction.include?("PLACE")
              if valid_coordinates?(instruction) == false
                instruction = file.gets
              else
                robot = robot_position(instruction)
              end
            end
            robot.validate
            puts "Output: Position out of grid" unless robot.valid?
            navigate(instruction.chomp, robot) if %w(move left right).any? { |str| instruction.downcase.include? str }
            report(robot) if instruction.chomp == "REPORT"
          end
        end

        file.close
      rescue => e
        puts e.message
      end
    end

    def robot_position(instruction)
      instruction.slice!("PLACE")

      coordinates = instruction.lstrip!.split(',')
      Robot.new(coordinates[0].to_i, coordinates[1].to_i, coordinates[2].chomp)
    end

    def navigate(instruction, robot)
      case instruction
        when "MOVE"
          robot.move_forward
        when "LEFT"
          robot.rotate_left
        when "RIGHT"
          robot.rotate_right
      end
    end

    def report(robot)
      puts "Output: #{robot.current_position.x}, #{robot.current_position.y} #{robot.current_direction}"
    end

    private

    def valid_coordinates?(instruction)

      if valid_place_instruction?(instruction)
        instruction_temp = instruction.lstrip
        coordinate = instruction_temp.split(',')

        coordinate_x = coordinate[0] unless coordinate[0].nil?
        coordinate_y = coordinate[1] unless coordinate[1].nil?

        if coordinate[2].nil?
          coordinate_direction = " "
        else
          coordinate_direction = coordinate[2]
        end


        (coordinate_x =~ /[[:digit:]]/).nil? ? (result = false) : (result = true)
        (coordinate_y =~ /[[:digit:]]/).nil? ? (result = false) : (result = true)
        %w(NORTH SOUTH EAST WEST).any? { |str| coordinate_direction.include? str } ? (result = true) : (result = false)

      else
        result = false
      end
      result
    end

    def valid_place_instruction?(instruction)
      if instruction.lstrip == nil
        result = false
      else
        instruction.split(',').empty? ? (result = false) : (result = true)
      end
      result
    end
  end
end