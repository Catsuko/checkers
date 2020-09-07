require 'checkers/movement/out_of_bounds'

module Checkers
    module Movement
        class Position
            LIMIT = 8

            def initialize(x, y)
                raise OutOfBounds unless in_bounds?(x, y)
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

            private

            def in_bounds?(x, y)
                x >= 0 && y >= 0 && x < LIMIT && y < LIMIT
            end
        end
    end
end