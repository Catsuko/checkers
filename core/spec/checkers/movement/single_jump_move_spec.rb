require 'spec_helper'
require 'support/shared_contexts/game_context'
require 'checkers'

RSpec.describe Checkers::Game do
  describe 'when getting the available moves for a piece,' do
    include_context('game')

    context 'given a dark piece,' do
      let(:piece) { Checkers::Piece.new('dark', light: false) }
      subject { game.moves_for(piece) }

      context 'with a jumpable light piece diagonally adjacent,' do
        let(:other_pieces) { { Checkers::Piece.new('light', light: true) => position.top_right } }
        let(:position) { Checkers::Movement::Position.new(2, 0) }
        
        it { is_expected.to contain_exactly(position.top_right.top_right) }

        context 'and the piece is next to the edge,' do
          let(:position) { Checkers::Movement::Position.new(0, 0) }

          it { is_expected.to contain_exactly(position.top_right.top_right) }
        end
      end
    end
  end
end