require_relative './movement/diagonal_move'
require_relative './movement/composite_move'

module Checkers
  class Piece
    def initialize(id, light:, movement:)
      @id = id
      @light = light
      @movement = movement
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
