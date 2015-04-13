require "minitest/autorun"
require_relative "robot"

describe Robot do

  describe 'MOVE instruction' do
    robot = Robot.new(6,6)

    describe 'with valid parameters' do
      before do
        robot.place("2,2,WEST")
      end

      it 'must move' do
        robot.move
        robot.current_position.x.must_equal 1
      end

      it 'must be valid' do
        robot.move
        robot.valid.must_equal true
      end
    end

    describe 'with invalid parameters' do
      before do
        robot.place("-6,-6,NORTH")
      end

      it 'must not be valid' do
        robot.move
        robot.valid.must_equal false
      end
    end

    describe 'out of grid instructions' do
      it 'ignores move instruction beyond y axis' do
        robot.place("4,6,NORTH")
        robot.move
        robot.current_position.y.must_equal 6
      end

      it 'ignores move instruction beyond x axis' do
        robot.place("0,4,SOUTH")
        robot.move
        robot.current_position.x.must_equal 0
      end
    end

    describe 'moves robot' do
      it 'moves into correct position and direction' do
        robot.place("1,2,EAST")
        robot.move
        robot.move
        robot.left

        robot.current_direction.must_equal "NORTH"
        robot.current_position.x.must_equal 3
      end
    end
  end

  describe 'PLACE instruction' do
    describe 'valid parameters' do

    end
  end

end