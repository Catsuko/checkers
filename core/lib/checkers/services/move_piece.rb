require_relative '../game_factory'

module Checkers
  module Services
    class MovePiece
      def initialize(listener, repository)
        @listener = listener
        @repository = repository
      end

      def call(game_id, piece_id, position)
        game_attributes = @repository.get(game_id)
        game = Checkers::GameFactory.new.create_from(game_attributes)
        updated_game = game.move(piece(piece_id, game_attributes.fetch(:pieces)), to: Checkers::Position.from_index(position))
        @repository.save(id: game_id, **updated_game.to_h)
        invoke_listener(updated_game, game_id)
      end

      private

      def piece(id, pieces)
        Checkers::PieceFactory.new.create_from(pieces.values.detect{ |piece| piece.fetch(:id) == id } || {})
      end

      def invoke_listener(game, id)
        @listener.handle_piece_moved(id)
        game.finished? do |winner, loser|
          @listener.handle_game_finished(winner.to_s, loser.to_s)
        end
      end
    end
  end
end