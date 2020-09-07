require 'spec_helper'
require 'checkers'
require 'checkers/movement/piece_missing'
require 'checkers/movement/out_of_turn'

RSpec.describe Checkers::Game do
    describe 'when moving a piece,' do
        let(:pieces) { {} }
        let(:first_player) { Checkers::Player.new('Player 1') }
        let(:second_player) { Checkers::Player.new('Player 2') }
        let(:start) { Checkers::Movement::Position.new(0, 0) }
        let(:finish) { Checkers::Movement::Position.new(1, 1) }
        subject { Checkers::Game.new(pieces, first: first_player, second: second_player) }

        context 'given there is no piece at the provided location,' do
            it 'an Invalid Move error is raised' do
                expect{ subject.move(start, finish) }.to raise_error(Checkers::Movement::PieceMissing)
            end
        end

        context 'given the piece at the starting position belongs to the active player,' do
            let(:piece) { Checkers::Piece.new('The Piece!', owner: first_player) }
            let(:pieces) { { piece => start } }

            it 'the piece is moved from the start to the finish' do
                updated_game = subject.move(start, finish)
                expect(updated_game.position_of(piece)).to eq finish
            end
        end

        context 'given the piece does not belong to the active player,' do
            let(:piece) { Checkers::Piece.new('The Piece!', owner: second_player) }
            let(:pieces) { { piece => start } }

            it 'an Out of Turn error is raised,' do
                expect{ subject.move(start, finish) }.to raise_error(Checkers::Movement::OutOfTurn)
            end
        end
    end
end