module Checkers
  class Turn
    def initialize(number=1, first_player:, second_player:)
      raise ArgumentError, 'Turn number must be positive' unless number.positive?

      @number = number
      @first_player = first_player
      @second_player = second_player
    end

    def current_player
      even? ? @second_player : @first_player
    end

    def waiting_player
      current_player == @first_player ? @second_player : @first_player
    end

    def next
      Turn.new(@number.next, first_player: @first_player, second_player: @second_player)
    end

    def even?
      @number.even?
    end
    
    def inspect
      "<Turn #{@number}>"
    end

    def to_h
      { number: @number }
    end
  end
end