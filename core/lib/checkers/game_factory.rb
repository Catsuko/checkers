require_relative 'piece_factory'
require_relative 'game'
require_relative 'turn'
require_relative 'position'

module Checkers
  class GameFactory
    def fresh(first_player, second_player)
      Game.new(fresh_pieces, turn: first_turn(first_player, second_player))
    end

    private

    def first_turn(first_player, second_player)
      Turn.new(first_player: first_player, second_player: second_player)
    end

    def fresh_pieces
      {}.tap do |pieces|
        valid_coordinates.take(12).each_with_index do |coords, i|
          pieces.store(piece_factory.create_dark_piece(-i.next), Position.new(*coords))
        end
        valid_coordinates.drop(20).each_with_index do |coords, i|
          pieces.store(piece_factory.create_light_piece(i.next), Position.new(*coords))
        end
      end
    end

    def piece_factory
      @piece_factory ||= PieceFactory.new
    end

    def valid_coordinates
      board_coordinates.select{ |x, y| x.even? == y.even? }
    end

    def board_coordinates
      Position::LIMIT.pow(2).times.map do |n|
        [n % Position::LIMIT, (n / Position::LIMIT).floor]
      end
    end
  end
end