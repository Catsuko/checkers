RSpec.shared_context 'game' do
  let(:first_player) { Checkers::Player.new('Player 1') }
  let(:second_player) { Checkers::Player.new('Player 2') }
  let(:turn) { Checkers::Turn.new(first_player: first_player, second_player: second_player) }
  let(:light_pieces) { [] }
  let(:dark_pieces) { [] }
  let(:piece) { nil }
  let(:position) { nil }
  let(:game) do
    pieces = {}
    pieces.store(piece, position) unless piece.nil? || position.nil?
    [light_pieces].flatten.each_with_index do |pos, i|
      pieces.store(Checkers::Piece.new(i.next, light: true), pos)
    end
    [dark_pieces].flatten.each_with_index do |pos, i|
      pieces.store(Checkers::Piece.new(-i.next, light: false), pos)
    end
    Checkers::Game.new(pieces, turn: turn)
  end
end