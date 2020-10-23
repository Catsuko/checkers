require_relative './movement/out_of_turn'
require_relative './movement/moves'
require_relative './out_of_bounds'

module Checkers
  class Game
    def initialize(pieces = {}, turn:, jumping_piece: nil)
      @pieces = pieces
      @turn = turn
      @jumping_piece = jumping_piece
    end
 
    def move(piece, to:)
      validate_move(piece, to: to)
      updated_pieces = pieces_after_moving(piece, to: to)

      if can_jump?(piece, from: @pieces[piece]) && can_jump?(piece, from: to)
        Game.new(updated_pieces, turn: @turn, jumping_piece: piece)
      else
        Game.new(updated_pieces, turn: @turn.next)
      end
    end

    def moves_for(piece)
      can_be_moved = @pieces.key?(piece) && (@jumping_piece.nil? || piece == @jumping_piece)
      Checkers::Movement::Moves.new(can_be_moved ? gather_moves_for(piece) : [])
    end

    def space_occupied?(position)
      positions = @pieces.invert
      positions.key?(position) && (!block_given? || yield(positions.fetch(position)))
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

    def to_h
      {
        turn: @turn.to_h,
        pieces: @pieces.reduce({}) { |hash, (k, v)| hash.merge({ v.hash => k.to_h }) },
        jumping_piece: @jumping_piece
      }
    end

    private

    def validate_move(piece, to:)
      raise Checkers::Movement::IllegalMove, "#{piece} is not part of the game." unless @pieces.key?(piece)
      raise Checkers::Movement::IllegalMove, "#{piece} at #{@pieces[piece]} cannot move to #{to}." unless moves_for(piece).include?(to)
      raise Checkers::Movement::OutOfTurn unless piece.own?(@turn)
    end

    def can_jump?(piece, from:)
      piece.jumps_from(from, game: self).any?
    end 

    def pieces_after_moving(piece, to:)
      origin = @pieces[piece]
      @pieces.merge({ piece => to }).tap do |pieces|
        promote_piece(piece, pieces: pieces, position: to) unless piece.king? || (!to.top_edge? && !to.bottom_edge?)
        removed_jumped_pieces(start: origin, finish: to, pieces: pieces) unless origin.next_to?(to)
      end
    end

    def promote_piece(piece, pieces:, position:)
      pieces.delete(piece)
      pieces.store(piece.promote, position)
    end

    def removed_jumped_pieces(start:, finish:, pieces:)
      space_occupied?(finish.move_towards(start)) {|jumped_piece| pieces.delete(jumped_piece) }
    end

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