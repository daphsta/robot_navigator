require_relative 'robot'
require_relative 'factories/instruction_factory'

class ReadInput

  class << self
    def instruction_from_file
      begin
        #Stdin while stdin get as string
        #pipe in
        #object send method_missing
        #robot.send(instruction.to_sym)

        robot = Robot.new
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