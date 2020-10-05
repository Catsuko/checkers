require 'spec_helper'
require 'support/shared_contexts/game_context'
require 'checkers'

RSpec.describe Checkers::Game do
  describe 'when getting the available moves for a piece,' do
    include_context('game')

    context 'given a dark piece,' do
      let(:piece) { Checkers::Piece.new('dark', light: false) }
      subject { game.moves_for(piece) }

      context 'with a diagonally adjacent light piece that has a vacant space behind,' do
        let(:other_pieces) { { Checkers::Piece.new('light', light: true) => position.top_right } }
        let(:position) { Checkers::Movement::Position.new(2, 2) }
        
        it { is_expected.to contain_exactly(position.top_right.top_right) }
      end

      context 'with a diagonally adjacent dark piece that has a vacant space behind,' do
        let(:other_pieces) { { Checkers::Piece.new('dark2', light: false) => position.top_right } }
        let(:position) { Checkers::Movement::Position.new(2, 2) }

        it { is_expected.to all(be_left_of(position)) }
      end

      context 'with a diagonally adjacent light piece that is on the left edge,' do
        let(:position) { Checkers::Movement::Position.new(1, 1) }
        let(:other_pieces) { { Checkers::Piece.new('light', light: true) => position.top_left } }

        it { is_expected.to all(be_right_of(position)) }
      end

      context 'with a diagonally adjacent light piece that is on the right edge,' do
        let(:position) { Checkers::Movement::Position.new(6, 0) }
        let(:other_pieces) { { Checkers::Piece.new('light', light: true) => position.top_right } }

        it { is_expected.to all(be_left_of(position)) }
      end
      
      context 'with a diagonally adjacent light piece that is on the top edge,' do
        let(:position) { Checkers::Movement::Position.new(0, 6) }
        let(:other_pieces) { { Checkers::Piece.new('light', light: true) => position.top_right } }

        it { is_expected.not_to be_any }
      end
    end
    context 'given a light piece,' do
      let(:piece) { Checkers::Piece.new('light', light: true) }
      subject { game.moves_for(piece) }

      context 'with a diagonally adjacent dark piece that has a vacant space behind,' do
        let(:other_pieces) { { Checkers::Piece.new('dark', light: false) => position.bottom_right } }
        let(:position) { Checkers::Movement::Position.new(2, 2) }
        
        it { is_expected.to contain_exactly(position.bottom_right.bottom_right) }
      end

      context 'with a diagonally adjacent light piece that has a vacant space behind,' do
        let(:other_pieces) { { Checkers::Piece.new('light2', light: true) => position.bottom_right } }
        let(:position) { Checkers::Movement::Position.new(2, 2) }

        it { is_expected.to all(be_left_of(position)) }
      end

      context 'with a diagonally adjacent dark piece that is on the left edge,' do
        let(:position) { Checkers::Movement::Position.new(1, 3) }
        let(:other_pieces) { { Checkers::Piece.new('dark', light: false) => position.bottom_left } }

        it { is_expected.to all(be_right_of(position)) }
      end

      context 'with a diagonally adjacent dark piece that is on the right edge,' do
        let(:position) { Checkers::Movement::Position.new(6, 2) }
        let(:other_pieces) { { Checkers::Piece.new('dark', light: false) => position.bottom_right } }

        it { is_expected.to all(be_left_of(position)) }
      end

      context 'with a diagonally adjacent dark piece that is on the bottom edge,' do
        let(:position) { Checkers::Movement::Position.new(7, 1) }
        let(:other_pieces) { { Checkers::Piece.new('dark', light: false) => position.bottom_left } }

        it { is_expected.not_to be_any }
      end
    end
  end
end