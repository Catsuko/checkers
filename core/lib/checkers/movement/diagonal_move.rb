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
        return unless vacant?(jump_position, game: game) && jumpable_piece?(continue_from(position), game: game, piece: piece)

        yield jump_position
      end

      def from(position, game:)
        return if horizontal_edge?(position) || vertical_edge?(position) || game.space_occupied?(continue_from(position))

        yield continue_from(position)
      end

      private

      def vacant?(position, game:)
        !game.space_occupied?(position)
      end

      def jumpable_piece?(position, game:, piece:)
        game.space_occupied?(position) { |other_piece| other_piece.enemy?(piece) }
      end

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