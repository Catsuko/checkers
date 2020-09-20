module Checkers
  class Game
    def initialize(pieces={}, turn:)
      @pieces = pieces
      @turn = turn
    end
  
    def moves_for(piece)
      raise Checkers::Movement::IllegalMove, 'That piece is not part of the game.' unless @pieces.key?(piece)
      raise Checkers::Movement::OutOfTurn unless piece.owned_by?(@turn.current_player)
    end
  end
end