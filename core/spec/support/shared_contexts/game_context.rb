require 'checkers/piece_factory'

RSpec.shared_context 'game' do
  let(:first_player) { Checkers::Player.new('Player 1') }
  let(:second_player) { Checkers::Player.new('Player 2') }
  let(:turn) { Checkers::Turn.new(first_player: first_player, second_player: second_player) }
  let(:light_pieces) { [] }
  let(:dark_pieces) { [] }
  let(:target_piece_position) { nil }
  let(:target_piece_color) { nil }
  let(:piece_factory) { Checkers::PieceFactory.new }
  let(:target_piece) { piece_factory.send(:"create_#{target_piece_color}_piece", 'target') unless target_piece_color.nil? }
  let(:game) do
    pieces = {}
    pieces.store(target_piece, target_piece_position) unless target_piece_position.nil?
    [light_pieces].flatten.each_with_index do |pos, i|
      pieces.store(piece_factory.create_light_piece(i.next), pos)
    end
    [dark_pieces].flatten.each_with_index do |pos, i|
      pieces.store(piece_factory.create_dark_piece(i.next), pos)
    end
    Checkers::Game.new(pieces, turn: turn)
  end
end