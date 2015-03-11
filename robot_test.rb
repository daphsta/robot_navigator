require "minitest/autorun"
require_relative "read_input"

class RobotTest < Minitest::Test
  def test_initial_place_not_out_of_grid
    robot = Robot.new(6,5,"NORTH")
    robot.validate
    assert_equal(false,robot.valid?)
  end

  def test_ignore_instructions_if_out_of_grid
    robot = Robot.new(5,5,"NORTH")
    robot.move_forward
    assert_equal(5,robot.current_position.x)
    assert_equal(5,robot.current_position.y)
  end

  def test_robot_initial_position_read
    instruction = "PLACE 1,2,EAST
                    MOVE
                    MOVE
                    LEFT
                    MOVE
                    REPORT"
    nav = instruction.split("\n")
    result = ReadInput.robot_position(nav[0])
    assert_equal(1,result.current_position.x)
    assert_equal(2,result.current_position.y)
    assert_equal("EAST",result.current_direction)
  end

  def test_robot_movements
    instruction = "PLACE 1,2,EAST\nMOVE\nMOVE\nLEFT\nMOVE\nREPORT"
    nav = instruction.split("\n")
    robot = ReadInput.robot_position(nav[0])
    (1..nav.size).each do |inst|
      ReadInput.navigate(nav[inst],robot)
    end
    assert_equal("NORTH",robot.current_direction)
    assert_equal(3,robot.current_position.x)
  end

  def test_should_not_go_out_of_x_plane
    instruction = "PLACE 2,2,WEST\nMOVE\nLEFT\nRIGHT\nMOVE\nMOVE\nRIGHT\nREPORT"
    nav = instruction.split("\n")
    robot = ReadInput.robot_position(nav[0])
    (1..nav.size).each do |inst|
      ReadInput.navigate(nav[inst],robot)
    end
    assert_equal("NORTH",robot.current_direction)
    assert_equal(0,robot.current_position.x)
  end

  def test_should_not_go_out_of_y_plane
    instruction = "PLACE 2,3,NORTH\nMOVE\nLEFT\nRIGHT\nMOVE\nMOVE\nMOVE\nRIGHT\nREPORT"
    nav = instruction.split("\n")
    robot = ReadInput.robot_position(nav[0])
    (1..nav.size).each do |inst|
      ReadInput.navigate(nav[inst],robot)
    end
    assert_equal("EAST",robot.current_direction)
    assert_equal(5,robot.current_position.y)
  end
end