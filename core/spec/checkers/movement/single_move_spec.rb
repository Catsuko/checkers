require 'spec_helper'
require 'support/shared_contexts/game_context'
require 'checkers'
require 'checkers/movement/illegal_move'

RSpec.describe Checkers::Game do
  describe 'when getting the available moves for a piece,' do
    include_context('game')

    context 'given the piece is not on the board,' do
      let(:pieces) { {} }
      let(:piece) { Checkers::Piece.new('id', light: false) }

      it 'there are no moves' do
        expect(game.moves_for(piece)).to be_none
      end
    end

    context 'given a dark piece,' do
      let(:piece) { Checkers::Piece.new('id', light: false) }
      subject { game.moves_for(piece) }

      context 'that is away from the edge,' do
        let(:position) { Checkers::Movement::Position.new(3, 3) }
       
        it { is_expected.to all(be_above(position)) }
        it { is_expected.to all(be_next_to(position)) }
        it { is_expected.to be_many }

        context 'with a friendly piece blocking the left space,' do
          let(:blocked_position) { Checkers::Movement::Position.new(2, 4) }
          let(:other_pieces) { {
            Checkers::Piece.new('id2', light: false) => blocked_position
          } }

          it { is_expected.not_to include(blocked_position) }
        end

        context 'with a friendly piece blocking the right space,' do
          let(:blocked_position) { Checkers::Movement::Position.new(4, 4) }
          let(:other_pieces) { {
            Checkers::Piece.new('id2', light: false) => blocked_position
          } }
          
          it { is_expected.not_to include(blocked_position) }
        end
      end

      context 'that is on the left edge,' do
        let(:position) { Checkers::Movement::Position.new(0, 2) }
  
        it { is_expected.to be_singular }
      end

      context 'that is on the right edge,' do
        let(:position) { Checkers::Movement::Position.new(7, 3) }

        it { is_expected.to be_singular }
      end
    end

    context 'given a light piece,' do
      let(:piece) { Checkers::Piece.new('id', light: true) }
      subject { game.moves_for(piece) }

      context 'that is away from the edge,' do
        let(:position) { Checkers::Movement::Position.new(3, 3) }

        it { is_expected.to all(be_below(position)) }
        it { is_expected.to all(be_next_to(position)) }
        it { is_expected.to be_many }

        context 'with a friendly piece blocking the left space,' do
          let(:blocked_position) { Checkers::Movement::Position.new(2, 2) }
          let(:other_pieces) { {
            Checkers::Piece.new('id2', light: true) => blocked_position
          } }

          it { is_expected.not_to include(blocked_position) }
        end

        context 'with a friendly piece blocking the right space,' do
          let(:blocked_position) { Checkers::Movement::Position.new(4, 2) }
          let(:other_pieces) { {
            Checkers::Piece.new('id2', light: true) => blocked_position
          } }

          it { is_expected.not_to include(blocked_position) }
        end
      end

      context 'that is on the left edge,' do
        let(:position) { Checkers::Movement::Position.new(0, 2) }
  
        it { is_expected.to be_singular }
      end
      
      context 'that is on the right edge,' do
        let(:position) { Checkers::Movement::Position.new(7, 3) }
  
        it { is_expected.to be_singular }
      end
    end
  end
end