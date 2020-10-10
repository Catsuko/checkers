require_relative './movement/out_of_turn'
require_relative './movement/moves'

module Checkers
  class Game
    def initialize(pieces={}, turn:)
      @pieces = pieces
      @turn = turn
    end
 
    def move(piece, to:, by:)
      raise Checkers::Movement::IllegalMove, "#{piece} is not part of the game." unless @pieces.key?(piece)
      raise Checkers::Movement::IllegalMove, "#{by} does not have permission to move #{piece}." if by == @turn.current_player && !piece.own?(@turn)
      raise Checkers::Movement::IllegalMove, "#{piece} at #{@pieces[piece]} cannot move to #{to}." unless moves_for(piece).include?(to)
      raise Checkers::Movement::OutOfTurn unless by == @turn.current_player
      raise Checkers::Movement::OutOfTurn unless piece.own?(@turn)

      origin = @pieces[piece]
      pieces_after_move = @pieces.merge({ piece => to })
      space_occupied?(to.move_towards(origin)) { |jumped_piece| pieces_after_move.delete(jumped_piece) } unless origin.next_to?(to)
      Game.new(pieces_after_move, turn: @turn.next)
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

    def current_player
      @turn.current_player
    end

    def finished?
      current_turn_pieces = @pieces.keys.select{ |piece| piece.own?(@turn) }
      current_turn_pieces.all?{ |piece| gather_moves_for(piece).none? }.tap do |is_finished|
        yield(@turn.waiting_player, @turn.current_player) if block_given? && is_finished
      end
    end

    def inspect
      "<Checkers::Game #{@turn.inspect}>"
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