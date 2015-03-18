require_relative 'robot'
require_relative 'factories/instruction_factory'

class ReadInput

  class << self
    def instruction_from_file
      begin
        instructions = File.read("input.txt",).split("\n")

        instructions.each do |instruction|
          instruction_type = find_instruction_type(instruction)

          if instruction_type.type.nil?
            next
          else
            move_robot(instruction_type, instruction)
          end
        end

      rescue => e
        puts e.message
      end
    end


    private

    def move_robot(instruction_type, instruction)
      if instruction_type.type == :place
        coordinate = instruction.split(' ')
        point_x    = coordinate[1].split(',')[0]
        point_y    = coordinate[1].split(',')[1]
        direction  = coordinate[1].split(',')[2]

        @bot = Robot.new(point_x.to_i, point_y.to_i, direction)
      elsif instruction_type.type == :report
        @bot.report
      else
        @bot.run(instruction)
      end
    end

    def find_instruction_type(instruction)
      InstructionFactory.build_instruction(instruction)
    end

  end
end