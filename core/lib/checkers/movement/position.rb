require 'checkers/movement/out_of_bounds'

module Checkers
  module Movement
    class Position
      LIMIT = 8

      def initialize(x, y)
        raise OutOfBounds.new(x: x, y: y) unless in_bounds?(x, y) && dark_square?(x, y)
        @x = x
        @y = y
      end

      def inspect
        "Position #{self.to_s}"
      end

      def to_s
        "(#{@x}, #{@y})"
      end

      def to_i
        @x + (@y * LIMIT)
      end

      def hash
        self.to_i
      end

      def is_at?(x, y)
        @x == x && y == @y
      end

      def ==(other)
        other.is_a?(Position) && other.is_at?(@x, @y)
      end

      def eql?(other)
        self == other
      end

      def top_left
        Position.new(@x.pred, @y.succ)
      end

      def top_right
        Position.new(@x.succ, @y.succ)
      end

      def bottom_left
        Position.new(@x.pred, @y.pred)
      end

      def bottom_right
        Position.new(@x.succ, @y.pred)
      end

      def top_edge?
        @y == LIMIT - 1
      end

      def bottom_edge?
        @y.zero?
      end
      
      def left_edge?
        @x.zero?
      end

      def right_edge?
        @x == LIMIT - 1
      end

      def above?(position)
        position.evaluate_y{ |y| y < @y }
      end

      def below?(position)
        position.evaluate_y{ |y| y > @y }
      end

      def left_of?(position)
        position.evaluate_x{ |x| x > @x }
      end

      def right_of?(position)
        position.evaluate_x{ |x| x < @x }
      end

      def next_to?(position)
        x_distance = position.evaluate_x{ |x| x - @x }.abs
        y_distance = position.evaluate_y{ |y| y - @y }.abs
        x_distance + y_distance > 0 && x_distance <= 1 && y_distance <= 1
      end

      def distance_from(position)
        position.evaluate_x{ |x| x - @x }.abs + position.evaluate_y{ |y| y - @y }.abs
      end

      def evaluate_x(&block)
        yield(@x)
      end

      def evaluate_y(&block)
        yield(@y)
      end

      private

      def in_bounds?(x, y)
        x >= 0 && y >= 0 && x < LIMIT && y < LIMIT
      end

      def dark_square?(x, y)
        x.even? == y.even?
      end
    end
  end
end