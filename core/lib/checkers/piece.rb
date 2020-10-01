module Checkers
  class Piece
    def initialize(id, light:)
      @id = id
      @light = light
    end

   def moves_from(position, game:)
      Enumerator.new do |moves|
        if @light
          moves << position.bottom_left unless position.left_edge? || game.space_occupied?(position.bottom_left)
          moves << position.bottom_right unless position.right_edge? || game.space_occupied?(position.bottom_right)
        else
          moves << position.top_left unless position.left_edge? || game.space_occupied?(position.top_left)
          moves << position.top_right unless position.right_edge? || game.space_occupied?(position.top_right) do |piece|
            potential_jump = position.top_right.top_right
            moves << potential_jump unless game.space_occupied?(potential_jump)
          end
        end
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
  end
end