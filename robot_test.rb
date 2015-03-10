require "minitest/autorun"
require_relative "read_input"

class RobotTest < Minitest::Test
  def test_initial_place_not_out_of_grid
    robot = Robot.new(6,5,"NORTH")
    assert_equal(robot.valid?,false)
  end

  def test_ignore_instructions_if_out_of_grid
    robot = Robot.new(5,5,"NORTH")
    robot.move_forward
    assert_equal(robot.current_position.x,5)
    assert_equal(robot.current_position.y,5)
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
    assert_equal(result.current_position.x, 1)
    assert_equal(result.current_position.y, 2)
    assert_equal(result.current_direction, "EAST")
  end

  def test_robot_movements
    instruction = "PLACE 1,2,EAST\nMOVE\nMOVE\nLEFT\nMOVE\nREPORT"
    nav = instruction.split("\n")
    robot = ReadInput.robot_position(nav[0])
    (1..nav.size).each do |inst|
      ReadInput.navigate(nav[inst],robot)
    end
    assert_equal(robot.current_direction, "NORTH")
    assert_equal(robot.current_position.x, 3)
  end

  def test_should_not_go_out_of_x_plane
    instruction = "PLACE 2,2,WEST\nMOVE\nLEFT\nRIGHT\nMOVE\nMOVE\nRIGHT\nREPORT"
    nav = instruction.split("\n")
    robot = ReadInput.robot_position(nav[0])
    (1..nav.size).each do |inst|
      ReadInput.navigate(nav[inst],robot)
    end
    assert_equal(robot.current_direction, "NORTH")
    assert_equal(robot.current_position.x, 0)
  end

  def test_should_not_go_out_of_y_plane
    instruction = "PLACE 2,3,NORTH\nMOVE\nLEFT\nRIGHT\nMOVE\nMOVE\nMOVE\nRIGHT\nREPORT"
    nav = instruction.split("\n")
    robot = ReadInput.robot_position(nav[0])
    (1..nav.size).each do |inst|
      ReadInput.navigate(nav[inst],robot)
    end
    assert_equal(robot.current_direction, "EAST")
    assert_equal(robot.current_position.y, 5)
  end
end