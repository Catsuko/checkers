require 'spec_helper'
require 'checkers'
require 'checkers/movement/illegal_move'

RSpec.describe Checkers::Game do
  describe 'when moving pieces,' do
    let(:first_player) { Checkers::Player.new('Player 1') }
    let(:second_player) { Checkers::Player.new('Player 2') }
    let(:turn) { Checkers::Turn.new(first_player: first_player, second_player: second_player) }
    let(:pieces) { { piece => position } }
    let(:game) { Checkers::Game.new(pieces, turn: turn) }

    context 'given the piece is not on the board,' do
      let(:pieces) { {} }
      let(:piece) { Checkers::Piece.new('id', owner: first_player) }

      it 'an Illegal Move error is raised' do
        expect{ first_player.move(piece, game: game) }.to raise_error(Checkers::Movement::IllegalMove)
      end
    end

    context 'given the piece is owned by the first player,' do
      let(:piece) { Checkers::Piece.new('id', owner: first_player) }
      subject { first_player.move(piece, game: game) }

      context 'and away from the edge,' do
        let(:position) { Checkers::Movement::Position.new(3, 3) }
        
        it 'the piece can move to the 2 adjacent positions above' do
          expect(subject).to contain_exactly(
            Checkers::Movement::Position.new(2, 4),
            Checkers::Movement::Position.new(4, 4)
          )
        end
      end

      context 'and is on the left edge,' do
        let(:position) { Checkers::Movement::Position.new(0, 2) }
  
        it 'the piece can move to the 2 adjacent positions above' do
          expect(subject).to contain_exactly(
            Checkers::Movement::Position.new(1, 3)
          )
        end
      end
    end

    context 'given the piece is owned by the second player,' do
      let(:turn) { Checkers::Turn.new(2, first_player: first_player, second_player: second_player) }
      let(:piece) { Checkers::Piece.new('id', owner: second_player) }
      subject { second_player.move(piece, game: game) }

      context 'and is away from the edge,' do
        let(:position) { Checkers::Movement::Position.new(3, 3) }

        it 'the piece can move to the 2 adjacent positions below' do
          expect(subject).to contain_exactly(
            Checkers::Movement::Position.new(2, 2),
            Checkers::Movement::Position.new(4, 2)
          )
        end
      end
    end
  end
end