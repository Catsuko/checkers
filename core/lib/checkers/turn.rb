module Checkers
    class Turn
        def initialize(number=1, first_player:, second_player:)
            raise ArgumentError, 'Turn number must be positive' unless number.positive?

            @number = number
            @first_player = first_player
            @second_player = second_player
        end

        def current_player
            @number % 2 == 0 ? @second_player : @first_player
        end

        def waiting_player
            current_player == @first_player ? @second_player : @first_player
        end
    end
end