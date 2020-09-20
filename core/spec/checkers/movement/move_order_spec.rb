require 'spec_helper'
require 'checkers'
require 'checkers/movement/out_of_turn'

RSpec.describe Checkers::Game do
  describe 'when taking turns to move pieces,' do
    let(:pieces) { {} }
    let(:first_player) { Checkers::Player.new('Player 1') }
    let(:second_player) { Checkers::Player.new('Player 2') }
    let(:turn) { Checkers::Turn.new(turn_number, first_player: first_player, second_player: second_player) }
    let(:game) { Checkers::Game.new({ piece => Checkers::Movement::Position.new(0, 0) }, turn: turn) }

    (1..5).each do |n|
      even_turn = n % 2 == 0
      context "given the player is going #{even_turn ? 'first' : 'second'} and it is turn #{n}," do
        let(:turn_number) { n }
        let(:piece) { Checkers::Piece.new('id', owner: turn.waiting_player) }

        it 'an Out of Turn error is raised' do 
          expect{ turn.waiting_player.move(piece, game: game) }.to raise_error(Checkers::Movement::OutOfTurn)
        end
      end
    end
  end
end