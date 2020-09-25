require_relative './movement/out_of_turn'
require_relative './movement/moves'

module Checkers
  class Game
    def initialize(pieces={}, turn:)
      @pieces = pieces
      @turn = turn
    end
 
    def move(piece, to:, by:)
      raise Checkers::Movement::IllegalMove, 'That piece is not part of the game.' unless @pieces.key?(piece)
      raise Checkers::Movement::IllegalMove, 'Player does not have permission to move piece.' if by == @turn.current_player && !piece.own?(@turn)
      raise Checkers::Movement::OutOfTurn unless by == @turn.current_player
      raise Checkers::Movement::OutOfTurn unless piece.own?(@turn)
    end

    def moves_for(piece)
      moves = @pieces.key?(piece) ? piece.moves_from(@pieces[piece], game: self) : []
      Checkers::Movement::Moves.new(moves)
    end

    def space_occupied?(position)
      @pieces.invert.key?(position)
    end
  end 
end