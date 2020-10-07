require_relative './movement/diagonal_move'
require_relative './movement/composite_move'

module Checkers
  class Piece
    def initialize(id, light:, movement:)
      @id = id
      @light = light
      @movement = movement
    end

    def moves_from(position, game:)
      jumps_exist = false
      Enumerator.new do |moves|
        @movement.jumps_for(self, position: position, game: game) do |jump|
          moves << jump
          jumps_exist = true
        end
        @movement.from(position, game: game) do |move|
          moves << move
        end unless jumps_exist
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
