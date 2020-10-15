require 'spec_helper'
require 'checkers'
require 'checkers/piece_factory'

RSpec.describe Checkers::Game do
  describe 'when getting the available jumps for a king,' do
    let(:piece_factory) { Checkers::PieceFactory.new }
    let(:king) { piece_factory.create_dark_piece('king').promote }
    let(:game) do
      pieces = { king => king_position }
      light_pieces.each do |position| 
        pieces.store(piece_factory.create_light_piece(position.to_s), position)
      end
      Checkers::Game.new(pieces, turn: nil) 
    end

    subject { game.moves_for(king) }

    context 'given the king is surrounded by jumpable pieces,' do
      let(:king_position) { Checkers::Position.new(3, 3) }
      let(:light_pieces) { [
        king_position.top_left,
        king_position.top_right,
        king_position.bottom_left,
        king_position.bottom_right
      ] }

      it do 
        is_expected.to contain_exactly(
          king_position.top_left.top_left,
          king_position.top_right.top_right,
          king_position.bottom_left.bottom_left,
          king_position.bottom_right.bottom_right
        )
      end
    end
  end
end