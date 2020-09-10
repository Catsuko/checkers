module Checkers
    module Movement
        class IllegalMove < StandardError
            def initialize(msg='Player was not allowed to move the piece.')
                super
            end
        end
    end
end