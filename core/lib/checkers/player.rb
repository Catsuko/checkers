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
    end
end