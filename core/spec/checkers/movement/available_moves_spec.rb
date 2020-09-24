require 'spec_helper'
require 'checkers'
require 'checkers/movement/illegal_move'

RSpec.describe Checkers::Game do
  describe 'when getting the available moves for a piece,' do
    let(:first_player) { Checkers::Player.new('Player 1') }
    let(:second_player) { Checkers::Player.new('Player 2') }
    let(:turn) { Checkers::Turn.new(first_player: first_player, second_player: second_player) }
    let(:pieces) { { piece => position } }
    let(:game) { Checkers::Game.new(pieces, turn: turn) }

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
        
        it 'the piece can move to the 2 adjacent positions above' do
          expect(subject).to contain_exactly(
            Checkers::Movement::Position.new(2, 4),
            Checkers::Movement::Position.new(4, 4)
          )
        end
      end

      context 'that is on the left edge,' do
        let(:position) { Checkers::Movement::Position.new(0, 2) }
  
        it 'the piece can only move up and away from the edge' do
          expect(subject).to contain_exactly(
            Checkers::Movement::Position.new(1, 3)
          )
        end
      end
      
      context 'that is on the right edge,' do
        let(:position) { Checkers::Movement::Position.new(7, 3) }
  
        it 'the piece can only move up and away from the edge' do
          expect(subject).to contain_exactly(
            Checkers::Movement::Position.new(6, 4)
          )
        end
      end
    end

    context 'given a light piece,' do
      let(:piece) { Checkers::Piece.new('id', light: true) }
      subject { game.moves_for(piece) }

      context 'that is away from the edge,' do
        let(:position) { Checkers::Movement::Position.new(3, 3) }

        it 'the piece can move to the 2 adjacent positions below' do
          expect(subject).to contain_exactly(
            Checkers::Movement::Position.new(2, 2),
            Checkers::Movement::Position.new(4, 2)
          )
        end
      end

      context 'that is on the left edge,' do
        let(:position) { Checkers::Movement::Position.new(0, 2) }
  
        it 'the piece can only move down and away from the edge' do
          expect(subject).to contain_exactly(
            Checkers::Movement::Position.new(1, 1)
          )
        end
      end
      
      context 'that is on the right edge,' do
        let(:position) { Checkers::Movement::Position.new(7, 3) }
  
        it 'the piece can only move down and away from the edge' do
          expect(subject).to contain_exactly(
            Checkers::Movement::Position.new(6, 2)
          )
        end
      end
    end
  end
end