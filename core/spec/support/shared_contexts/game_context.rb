RSpec.shared_context 'game' do
  let(:first_player) { Checkers::Player.new('Player 1') }
  let(:second_player) { Checkers::Player.new('Player 2') }
  let(:turn) { Checkers::Turn.new(first_player: first_player, second_player: second_player) }
  let(:pieces) { { piece => position, **other_pieces } }
  let(:other_pieces) { {} }
  let(:game) { Checkers::Game.new(pieces, turn: turn) }
end