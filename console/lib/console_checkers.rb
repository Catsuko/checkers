require_relative '../../core/lib/checkers'
require_relative 'adapters/console_game'
require_relative 'adapters/in_memory_repository'

repo = Adapters::InMemoryRepository.new
game = Adapters::ConsoleGame.new(repo)
create_command = Checkers::Services::CreateNewGame.new(game, repo)
move_command = Checkers::Services::MovePiece.new(game, repo)
game.play(create_command, move_command)