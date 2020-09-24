module Checkers
  class Piece
    def initialize(id, light:)
      @id = id
      @light = light
    end

   def moves_from(position)
      [].tap do |moves|
        if @light
          moves << position.bottom_left unless position.left_edge?
          moves << position.bottom_right unless position.right_edge?
        else
          moves << position.top_left unless position.left_edge?
          moves << position.top_right unless position.right_edge?
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

    def own?(turn)
      turn.even? == @light
    end
  end
end