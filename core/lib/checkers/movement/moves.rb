module Checkers
  module Movement
    class Moves
      include Enumerable

      def initialize(directions, piece:, game:)
        @directions = directions
        @piece = piece
        @game = game
      end

      def towards(direction)
        # move piece in direction, piece decides if this is valid or not.
        # returns instance of game with moved piece
      end

      def each(&block)
        if block_given?
          @directions.each(&block)
        else
          @directions.each
        end
      end
    end
  end
end