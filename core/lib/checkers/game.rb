module Checkers
  class Game
    def initialize(pieces={}, turn:)
      @pieces = pieces
      @turn = turn
    end
  
    def moves_for(piece)
      raise Checkers::Movement::IllegalMove, 'That piece is not part of the game.' unless @pieces.key?(piece)
      raise Checkers::Movement::OutOfTurn unless piece.owned_by?(@turn.current_player)

      Checkers::Movement::Moves.new(available_moves(piece), piece: piece, game: self)      
    end

    private

    def available_moves(piece)
      current_position = @pieces[piece]
      
      [].tap do |moves|
        moves << current_position.top_left unless current_position.left_edge?
        moves << current_position.top_right unless current_position.right_edge?
      end
    end
  end
end