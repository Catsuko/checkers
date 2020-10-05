RSpec.shared_context 'game' do
  let(:first_player) { Checkers::Player.new('Player 1') }
  let(:second_player) { Checkers::Player.new('Player 2') }
  let(:turn) { Checkers::Turn.new(first_player: first_player, second_player: second_player) }
  let(:light_pieces) { [] }
  let(:dark_pieces) { [] }
  let(:target_piece_position) { nil }
  let(:target_piece_color) { nil }
  let(:target_piece) { Checkers::Piece.regular('target', light: target_piece_color == :light) unless target_piece_color.nil? }
  let(:game) do
    pieces = {}
    pieces.store(target_piece, target_piece_position) unless target_piece_position.nil?
    [light_pieces].flatten.each_with_index do |pos, i|
      pieces.store(Checkers::Piece.regular(i.next, light: true), pos)
    end
    [dark_pieces].flatten.each_with_index do |pos, i|
      pieces.store(Checkers::Piece.regular(-i.next, light: false), pos)
    end
    Checkers::Game.new(pieces, turn: turn)
  end
end