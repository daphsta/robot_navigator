module InstructionValidator

  def valid_coordinates?(instruction)
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

    result
  end
end