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
            robot = robot_position(instruction) if instruction.include?("PLACE")
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
  end

end