require "minitest/autorun"
require_relative "read_input"


class RobotTest < Minitest::Test
  def test_validate_out_of_grid
    inst = "4,6,NORTH"
    robot = Robot.new(6,6)
    robot.place(inst)
    robot.move

    assert_equal(false,robot.valid)
  end

  def test_validate_negative_coordinate
    inst = "-6,-6,NORTH"
    robot = Robot.new(6,6)
    robot.place(inst)
    robot.move

    assert_equal(false,robot.valid)
  end

  def test_ignore_instructions_if_out_of_grid
    inst = "5,5,NORTH"
    robot = Robot.new(6,6)
    robot.place(inst)
    robot.move

    assert_equal(5,robot.current_position.x)
    assert_equal(5,robot.current_position.y)
  end


  def test_robot_movements
    robot = Robot.new(6,6)
    robot.place("1,2,EAST")
    robot.move
    robot.move
    robot.left


    assert_equal("NORTH",robot.current_direction)
    assert_equal(3,robot.current_position.x)
  end

  def test_should_not_go_out_of_x_plane
    robot = Robot.new(6,6)
    robot.place("2,2,WEST")
    robot.move
    robot.left
    robot.right
    robot.move
    robot.move
    robot.right

    assert_equal("NORTH",robot.current_direction)
    assert_equal(0,robot.current_position.x)
  end

  def test_should_not_go_out_of_y_plane
    robot = Robot.new(6,6)
    robot.place("2,3,NORTH")
    robot.move
    robot.left
    robot.right
    robot.move
    robot.move
    robot.move
    robot.right

    assert_equal("EAST",robot.current_direction)
    assert_equal(5,robot.current_position.y)
  end

end