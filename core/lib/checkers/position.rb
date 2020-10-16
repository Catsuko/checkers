require_relative './out_of_bounds'

module Checkers
  class Position
    LIMIT = 8

    attr_reader :x, :y

    def initialize(x, y)
      in_bounds = x >= 0 && y >= 0 && x < LIMIT && y < LIMIT
      dark_square = x.even? == y.even?
      raise OutOfBounds.new(x: x, y: y) unless in_bounds && dark_square

      @x = x
      @y = y
    end

    def inspect
      "Position #{self.to_s}"
    end

    def to_s
      "(#{x}, #{y})"
    end

    def hash
      x + (y * LIMIT)
    end

    def ==(other)
      other.is_a?(Position) && other.x == x && other.y == y
    end

    def eql?(other)
      self == other
    end

    def top_left
      Position.new(x.pred, y.succ)
    end

    def top_right
      Position.new(x.succ, y.succ)
    end

    def bottom_left
      Position.new(x.pred, y.pred)
    end

    def bottom_right
      Position.new(x.succ, y.pred)
    end

    def top_edge?
      y == LIMIT - 1
    end

    def bottom_edge?
      y.zero?
    end
      
    def left_edge?
      x.zero?
    end

    def right_edge?
      x == LIMIT - 1
    end

    def above?(position)
      y > position.y
    end

    def below?(position)
      y < position.y
    end

    def left_of?(position)
      x < position.x
    end

    def right_of?(position)
      x > position.x
    end

    def next_to?(position)
      x_distance = (position.x - x).abs
      y_distance = (position.y - y).abs
      x_distance + y_distance > 0 && x_distance <= 1 && y_distance <= 1
    end

    def move_towards(other)
      x_dir = other.x - x <=> 0
      y_dir = other.y - y <=> 0
      Position.new(x + x_dir, y + y_dir)
    end
  end
end