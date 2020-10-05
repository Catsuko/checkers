require 'spec_helper'
require 'support/shared_contexts/game_context'
require 'checkers'

RSpec.describe Checkers::Game do
  describe 'when getting the available moves for a piece,' do
    include_context('game')

    context 'given a dark piece,' do
      let(:target_piece_color) { :dark }
      subject { game.moves_for(target_piece) }

      context 'with a diagonally adjacent light piece that has a vacant space behind,' do
        let(:target_piece_position) { Checkers::Movement::Position.new(2, 2) }
        let(:light_pieces) { target_piece_position.top_right }
        
        it { is_expected.to contain_exactly(target_piece_position.top_right.top_right) }
      end

      context 'with a diagonally adjacent dark piece that has a vacant space behind,' do
        let(:target_piece_position) { Checkers::Movement::Position.new(2, 2) }
        let(:dark_pieces) { target_piece_position.top_right }

        it { is_expected.to all(be_left_of(target_piece_position)) }
      end

      context 'with a diagonally adjacent light piece that is on the left edge,' do
        let(:target_piece_position) { Checkers::Movement::Position.new(1, 1) }
        let(:light_pieces) { target_piece_position.top_left }

        it { is_expected.to all(be_right_of(target_piece_position)) }
      end

      context 'with a diagonally adjacent light piece that is on the right edge,' do
        let(:target_piece_position) { Checkers::Movement::Position.new(6, 0) }
        let(:light_pieces) { target_piece_position.top_right }

        it { is_expected.to all(be_left_of(target_piece_position)) }
      end
      
      context 'with a diagonally adjacent light piece that is on the top edge,' do
        let(:target_piece_position) { Checkers::Movement::Position.new(0, 6) }
        let(:light_pieces) { target_piece_position.top_right }

        it { is_expected.not_to be_any }
      end
    end
    context 'given a light piece,' do
      let(:target_piece_color) { :light }
      subject { game.moves_for(target_piece) }

      context 'with a diagonally adjacent dark piece that has a vacant space behind,' do
        let(:target_piece_position) { Checkers::Movement::Position.new(2, 2) }
        let(:dark_pieces) { target_piece_position.bottom_right }
        
        it { is_expected.to contain_exactly(target_piece_position.bottom_right.bottom_right) }
      end

      context 'with a diagonally adjacent light piece that has a vacant space behind,' do
        let(:target_piece_position) { Checkers::Movement::Position.new(2, 2) }
        let(:light_pieces) { target_piece_position.bottom_right }

        it { is_expected.to all(be_left_of(target_piece_position)) }
      end

      context 'with a diagonally adjacent dark piece that is on the left edge,' do
        let(:target_piece_position) { Checkers::Movement::Position.new(1, 3) }
        let(:dark_pieces) { target_piece_position.bottom_left }

        it { is_expected.to all(be_right_of(target_piece_position)) }
      end

      context 'with a diagonally adjacent dark piece that is on the right edge,' do
        let(:target_piece_position) { Checkers::Movement::Position.new(6, 2) }
        let(:dark_pieces) { target_piece_position.bottom_right }

        it { is_expected.to all(be_left_of(target_piece_position)) }
      end

      context 'with a diagonally adjacent dark piece that is on the bottom edge,' do
        let(:target_piece_position) { Checkers::Movement::Position.new(7, 1) }
        let(:dark_pieces) { target_piece_position.bottom_left }

        it { is_expected.not_to be_any }
      end
    end
  end
end