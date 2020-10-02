module Checkers
  class Piece
    def initialize(id, light:)
      @id = id
      @light = light
    end

   def moves_from(position, game:)
      jumps_exist = false
      Enumerator.new do |moves|
        jump_moves(position, game: game) do |jump|
          moves << jump
          jumps_exist = true
        end
        regular_moves(position, game: game) { |move| moves << move } unless jumps_exist
      end
    end

    def has_id?(id)
      @id == id
    end

    def ==(other)
      other.is_a?(Piece) && other.has_id?(@id)
    end

    def eql?(other)
      other == self
    end

    def hash
      @id.hash
    end

    def friendly?(other)
      light? == other.light?
    end

    def light?
      @light
    end

    def own?(turn)
      turn.even? == @light
    end

    private

    # TODO: Add tests for jumping when 1 away from the edge, likely the current code will break
    # TODO: Feels like the logic for a jump and a regular move belongs together united under the direction being moved.
    #       Refactoring is still needed!
    def jump_moves(position, game:)
      game.space_occupied?(position.send(right_direction)) do |piece|
        potential_jump = position.send(right_direction).send(right_direction)
        yield potential_jump unless game.space_occupied?(potential_jump)
      end unless position.right_edge?
      
      game.space_occupied?(position.send(left_direction)) do |piece|
        potential_jump = position.send(left_direction).send(left_direction)
        yield potential_jump unless game.space_occupied?(potential_jump)
      end unless position.left_edge?
    end

    def regular_moves(position, game:)
      yield position.send(right_direction) unless position.right_edge? || game.space_occupied?(position.send(right_direction))
      yield position.send(left_direction) unless position.left_edge? || game.space_occupied?(position.send(left_direction))
    end

    def right_direction
      light? ? :bottom_right : :top_right
    end

    def left_direction
      light? ? :bottom_left : :top_left
    end
  end
end