module Checkers
  module Movement
    class Moves
      include Enumerable

      delegate :each, to: :@directions

      def initialize(directions, piece:, game:)
        @directions = directions
        @piece = piece
        @game = game
      end

      def towards(direction)
        # move piece in direction, piece decides if this is valid or not.
        # returns instance of game with moved piece
      end
    end
  end
end