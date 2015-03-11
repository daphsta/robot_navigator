require "minitest/autorun"
require_relative "instruction_validator"

class InstructionValidatorTest < Minitest::Test

  def test_coordinates_not_number
    dummy_class = DummyClass.new
    invalid_coordinates = "invalid_coordinates"
    result = dummy_class.valid_coordinates?(invalid_coordinates)
    assert_equal(false,result)
  end

  def test_direction_invalid
    dummy_class = DummyClass.new
    invalid_direction = "0,0,invalid_direction"
    result = dummy_class.valid_coordinates?(invalid_direction)
    assert_equal(false,result)
  end

  def test_invalid_y_coordinate
    dummy_class = DummyClass.new
    invalid_y_coordinate = "0,invalid_y,invalid_direction"
    result = dummy_class.valid_coordinates?(invalid_y_coordinate)
    assert_equal(false,result)
  end

  def test_empty_string_after_PLACE_instruction
    dummy_class = DummyClass.new
    empty_string_instruction = ""
    result = dummy_class.valid_place_instruction?(empty_string_instruction)
    assert_equal(false,result)
  end

  def test_space_after_PLACE_instruction
    dummy_class = DummyClass.new
    empty_string_instruction = "  "
    result = dummy_class.valid_place_instruction?(empty_string_instruction)
    assert_equal(false,result)
  end
end

class DummyClass
  include InstructionValidator
end