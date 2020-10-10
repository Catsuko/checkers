module Checkers
  module Movement
    class OutOfBounds < StandardError
      def initialize(x:,y:)
        @x = x
        @y = y
      end

      def inspect
        "<Checkers::Movement::OutOfBounds: #{@x}, #{@y}>"
      end

      def to_s
        inspect
      end
    end
  end
end