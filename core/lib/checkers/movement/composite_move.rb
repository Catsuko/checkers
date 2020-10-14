module Checkers
  module Movement
    class CompositeMove
      def initialize(moves)
        @moves = moves
      end

      def with_opposites
        CompositeMove.new(@moves + @moves.map(&:opposite))
      end

      def jumps_for(piece, position:, game:, &block)
        self.tap do
          @moves.each do |move|
            move.jumps_for(piece, position: position, game: game, &block)
          end
        end
      end

      def from(position, game:, &block)
        self.tap do
          @moves.each do |move| 
            move.from(position, game: game, &block)
          end
        end
      end
    end
  end
end