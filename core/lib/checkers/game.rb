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
      raise Checkers::Movement::IllegalMove, "#{piece} is not part of the game." unless @pieces.key?(piece)
      raise Checkers::Movement::IllegalMove, "#{piece} at #{@pieces[piece]} cannot move to #{to}." unless moves_for(piece).include?(to)
      raise Checkers::Movement::OutOfTurn unless piece.own?(@turn)

      if can_jump?(piece, from: to)
        Game.new(pieces_after_moving(piece, to: to), turn: @turn, jumping_piece: piece)
      else
        Game.new(pieces_after_moving(piece, to: to), turn: @turn.next)
      end
    end

    def moves_for(piece)
      can_be_moved = @pieces.key?(piece) && (@jumping_piece.nil? || piece == @jumping_piece)
      Checkers::Movement::Moves.new(can_be_moved ? gather_moves_for(piece) : [])
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

    def can_jump?(piece, from:)
      piece.jumps_from(from, game: self).any?
    end 

    def pieces_after_moving(piece, to:)
      origin = @pieces[piece]
      @pieces.merge({ piece => to }).tap do |pieces|
        unless(origin.next_to?(to))
          space_occupied?(to.move_towards(origin)) {|jumped_piece| pieces.delete(jumped_piece) }
        end
      end
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