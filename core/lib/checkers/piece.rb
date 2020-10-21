module Checkers
  class Piece
    def initialize(id, light:, movement:, is_king: false)
      @id = id
      @light = light
      @movement = movement
      @is_king = is_king
    end

    def promote
      Piece.new(@id, light: @light, movement: @movement.with_opposites, is_king: true)
    end

    def jumps_from(position, game:)
      Enumerator.new do |jumps|
        @movement.jumps_for(self, position: position, game: game) do |jump|
          jumps << jump
        end
      end
    end

    def moves_from(position, game:)
      Enumerator.new do |moves|
        @movement.from(position, game: game) do |move|
          moves << move
        end
      end
    end

    def king?
      @is_king
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

    def enemy?(other)
      !friendly?(other)
    end

    def light?
      @light
    end

    def own?(turn)
      turn.even? == @light
    end

    def to_s
      "##{@id} #{light? ? 'Light' : 'Dark'} Piece"
    end

    def to_h
      {
        id: @id,
        light: @light,
        is_king: @is_king
      }
    end
  end
end
