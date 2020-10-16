module Checkers
  module Movement
    class DiagonalMove
      def initialize(x_dir:, y_dir:)
        @x_dir = x_dir
        @y_dir = y_dir
      end

      def opposite
        DiagonalMove.new(
          x_dir: @x_dir == :left ? :right : :left,
          y_dir: @y_dir == :top ? :bottom : :top
        )
      end

      def jumps_for(piece, position:, game:)
        return unless room_to_jump?(position)
        
        jump_position = continue_from(position, count: 2)
        game.space_occupied?(continue_from(position)) do |other_piece|
          yield jump_position unless game.space_occupied?(jump_position) || other_piece.friendly?(piece)
        end
      end

      def from(position, game:)
        yield continue_from(position) unless horizontal_edge?(position) || vertical_edge?(position) || game.space_occupied?(continue_from(position))
      end

      private

      def room_to_jump?(position)
        !horizontal_edge?(position) &&
          !vertical_edge?(position) &&
          !horizontal_edge?(continue_from(position)) &&
          !vertical_edge?(continue_from(position))
      end

      def vertical_edge?(position)
        position.send(:"#{@y_dir}_edge?")
      end

      def horizontal_edge?(position)
        position.send(:"#{@x_dir}_edge?")
      end

      def continue_from(position, count: 1)
        count.times.reduce(position) do |pos|
          pos.send(:"#{@y_dir}_#{@x_dir}")
        end
      end
    end
  end
end