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
      Checkers::Movement::Moves.new(@pieces.key?(piece) ? gather_moves_for(piece) : [])
    end

    def space_occupied?(position)
      positions = @pieces.invert
      positions.key?(position).tap do |is_occupied|
        yield(positions.fetch(position)) if block_given? && is_occupied
      end
    end

    private

    def gather_moves_for(piece)
      jumps = piece.jumps_from(@pieces[piece], game: self)
      jumps.any? || friendly_jump_exists?(piece) ? jumps : piece.moves_from(@pieces[piece], game: self)
    end

    def friendly_jump_exists?(piece)
      @pieces.keys.any? do |other_piece|
        other_piece != piece &&
        other_piece.friendly?(piece) && 
        other_piece.jumps_from(@pieces[other_piece], game: self).any?
      end
    end
  end 
end