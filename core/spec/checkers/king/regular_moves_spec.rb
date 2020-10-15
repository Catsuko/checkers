require 'spec_helper'
require 'checkers'
require 'checkers/piece_factory'

RSpec.describe Checkers::Game do
  describe 'when getting the available moves for a king,' do
    let(:king) { Checkers::PieceFactory.new.create_dark_piece('king').promote }
    let(:game) { Checkers::Game.new({ king => king_position }, turn: nil) }

    subject { game.moves_for(king) }

    context 'given the king is away from the edges of the board,' do
      let(:king_position) { Checkers::Position.new(4, 4) }

      it do 
        is_expected.to contain_exactly(
          king_position.top_left,
          king_position.top_right,
          king_position.bottom_left,
          king_position.bottom_right
        )
      end
    end
  end
end