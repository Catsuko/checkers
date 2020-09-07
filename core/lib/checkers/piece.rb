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

        def owned_by?(owner)
            @owner == owner
        end
    end
end