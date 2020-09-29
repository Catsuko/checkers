module Checkers
  module Movement
    class Moves
      include Enumerable

      def initialize(positions)
        @positions = positions
      end

      def each(&block)
        if block_given?
          @positions.each(&block)
        else
          @positions.each
        end
      end

      def inspect
        @positions.inspect
      end

      def many?
        @positions.size > 1
      end

      def singular?
        @positions.size == 1
      end
    end
  end
end