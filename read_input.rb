require_relative 'robot'

class ReadInput

  class << self
    def instruction_from_file
      begin
        robot = Robot.new(6,6)

        while(instruction = STDIN.gets)
          inst = instruction.split(' ')
          robot.send(inst[0].downcase.to_sym,inst[1])
        end

      rescue => e
        puts e.message
      end
    end

  end
end