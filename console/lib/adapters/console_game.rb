require 'colorize'
require 'stringio'
require 'byebug'

module Adapters
  # TODO: Separate views and input from game loop
  class ConsoleGame
    def initialize(repository, input)
      @repository = repository
      @input = input
    end

    def play(create_game_command, move_command)
      create_game_command.(*@input.player_names)

      loop do
        game_state = @repository.get(@game_id)
        begin
          move_command.(@game_id, *@input.select_move(game_state))
        rescue StandardError => e
          puts e, "\n"
        end
      end
    end

    def handle_game_created(game_id)
      @game_id = game_id
      render_game(@repository.get(game_id))
    end

    def handle_piece_moved(game_id)
      render_game(@repository.get(game_id))
    end

    def handle_game_finished(winner, loser)
      puts "\n#{winner} is the winner!\n"
    end

    private

    # TODO: Clean this hell up
    def render_game(game_state)
      first_player_color = :light_green
      second_player_color = :white
      pieces = game_state.fetch(:pieces)

      table_format = StringIO.new
      counter = 0
      8.times do |x|
        8.times do |y|
          background = x.even? == y.even? ? :light_black : :red
          piece_details = pieces.fetch(counter, {})
          color = piece_details[:light] ? second_player_color : first_player_color
          table_format << "%3s".colorize(color: color, background: piece_details[:is_king] ? :black : background)
          counter = counter.next
        end
        table_format << "\n"
      end
      piece_ids = 8.pow(2).times.map{ |i| game_state.fetch(:pieces)[i]&.fetch(:id).to_s }
      puts
      game_state.fetch(:turn).fetch(:number).tap do |turn_number|
        puts "TURN #{turn_number}".colorize(turn_number.odd? ? first_player_color : second_player_color)
      end
      printf(table_format.string, *piece_ids)
      puts
    end
  end
end