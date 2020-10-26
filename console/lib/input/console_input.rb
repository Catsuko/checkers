module Input
  class ConsoleInput
    def player_names
      ['Green', 'White']
    end

    def select_move(game_state)
      piece_details = select_piece(game_state.fetch(:pieces))
      [piece_details.first[:id], select_move_position(piece_details.last)]
    end

    private

    def select_piece(pieces)
      puts 'Which piece do you want to move?'
      id = gets.chomp
      pieces.invert.detect{ |piece, pos| piece[:id].to_s == id }.tap do |piece_details|
        raise "'#{id}' does not match a piece, pick a number from the board" if piece_details.nil?
      end
    end

    def select_move_position(from)
      puts "Where do you want to move? #{movement_map.keys.join(' ')}"
      from + movement_map.fetch(gets.chomp)
    end

    def movement_map
      @movement_map ||= {
        'se' => 9,
        'sw' => 7,
        'ne' => -7,
        'nw' => -9,
        'se jump' => 18,
        'sw jump' => 14,
        'ne jump' => -14,
        'nw jump' => -18
      }
    end
  end
end