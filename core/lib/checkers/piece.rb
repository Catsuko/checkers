module Checkers
  class Piece
    def initialize(id, owner:)
      @id = id
      @owner = owner
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

    def owned_by?(player)
      @owner == player
    end
  end
end