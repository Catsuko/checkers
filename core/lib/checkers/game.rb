require 'checkers/movement/piece_missing'

module Checkers
    class Game
        def initialize(pieces={}, first:, second:)
            @pieces = pieces
            @first = first
            @second = second
        end
    
        def move(start, finish)
            positions = @pieces.invert
            piece = positions[start]
            
            raise Checkers::Movement::PieceMissing unless piece
            raise Checkers::Movement::OutOfTurn unless piece.owned_by?(@first)

            Game.new(@pieces.merge({ positions[start] => finish }), first: @first, second: @second)
        end

        def position_of(piece)
            raise ArgumentError, "#{piece} is not in the game." unless @pieces.key?(piece)

            @pieces[piece]
        end
    end
end