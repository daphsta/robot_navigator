
Instruction = Struct.new(:type, :instruction)

class InstructionFactory
  InstructionTypes = {
    place: -> (instruction) { instruction.include?("PLACE") },
    move:  -> (instruction) { instruction.eql?("MOVE") },
    left:  -> (instruction) { instruction.eql?("LEFT") },
    right: -> (instruction) { instruction.eql?("RIGHT") }
  }

  def self.build_instruction(inst)
    Instruction.new(type_of_instruction(inst),inst)
  end

  def self.type_of_instruction(inst)
    InstructionTypes.each_key.detect { |type|
      InstructionTypes[type].call(inst)
    }
  end
end

