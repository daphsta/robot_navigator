require "minitest/autorun"
require_relative "read_input"
require 'minitest/mock'

class RobotTest < Minitest::Test
  def test_validate_out_of_grid
    inst = "6,6,NORTH"
    robot = Robot.new
    robot.place(inst)
    robot.move

    assert_equal(false,robot.valid)
  end

  def test_validate_negative_coordinate
    inst = "-6,-6,NORTH"
    robot = Robot.new
    robot.place(inst)
    robot.move

    assert_equal(false,robot.valid)
  end

  def test_ignore_instructions_if_out_of_grid
    inst = "5,5,NORTH"
    robot = Robot.new
    robot.place(inst)
    robot.move

    assert_equal(5,robot.current_position.x)
    assert_equal(5,robot.current_position.y)
  end


  def test_robot_movements
    place = "PLACE 1,2,EAST"
    robot = Robot.new
    robot.place(place)
    robot.move
    robot.move
    robot.left
    robot.report

    assert_equal("NORTH",robot.current_direction)
    assert_equal(3,robot.current_position.x)
  end
  #
  # def test_should_not_go_out_of_x_plane
  #   instruction = "PLACE 2,2,WEST\nMOVE\nLEFT\nRIGHT\nMOVE\nMOVE\nRIGHT\nREPORT"
  #
  #   assert_equal("NORTH",robot.current_direction)
  #   assert_equal(0,robot.current_position.x)
  # end
  #
  # def test_should_not_go_out_of_y_plane
  #   instruction = "PLACE 2,3,NORTH\nMOVE\nLEFT\nRIGHT\nMOVE\nMOVE\nMOVE\nRIGHT\nREPORT"
  #
  #   assert_equal("EAST",robot.current_direction)
  #   assert_equal(5,robot.current_position.y)
  # end

end