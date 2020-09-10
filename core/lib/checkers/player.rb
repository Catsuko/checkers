module Checkers
    class Player
        def initialize(id)
            @id = id
        end

        def has_id?(id)
            @id == id
        end

        def ==(other)
            other.is_a?(Player) && other.has_id?(@id)
        end

        def eql?(other)
            other == self
        end

        def hash
            @id.hash
        end

        def move(piece, game:)
            raise Checkers::Movement::IllegalMove unless piece.owned_by?(self)
            
            game.moves_for(piece)
        end
    end
end