require_relative '../game_factory'
require_relative '../player'

module Checkers
  module Services
    class CreateNewGame
      def initialize(listener, repository)
        @listener = listener
        @repository = repository
      end

      def call(first_player_id, second_player_id)
        if first_player_id == second_player_id
          raise ArgumentError, 'Failed to create new game, player ids are the same.'
        end

        @repository.generate_id.tap do |id|
          @repository.store(fresh_game_attributes(id, first_player_id, second_player_id))
          @listener.handle_game_created(id)
        end
      end

      private

      def fresh_game_attributes(game_id, first_player_id, second_player_id)
        {
          id: game_id,
          first_player_id: first_player_id,
          second_player_id: second_player_id,
          **fresh_game(Checkers::Player.new(first_player_id), Checkers::Player.new(second_player_id)).to_h
        }
      end

      def fresh_game(first_player, second_player)
        Checkers::GameFactory.new.fresh(first_player, second_player)
      end
    end
  end
end