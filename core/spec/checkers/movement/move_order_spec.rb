require 'spec_helper'
require 'checkers'
require 'checkers/movement/out_of_turn'
require 'support/shared_contexts/game_context'

RSpec.describe Checkers::Game do
  describe 'when taking turns to move pieces,' do
    include_context('game')
    let(:position) { Checkers::Movement::Position.new(1, 1) }

    (1..5).each do |n|
      even_turn = n % 2 == 0

      context "given the player is going #{even_turn ? 'first' : 'second'} and it is turn #{n}," do
        let(:turn_number) { n }
        let(:piece) { Checkers::Piece.new('id', light: !turn.even?) }

        it 'an Out of Turn error is raised' do 
          expect{ game.move(piece, to: position, by: turn.waiting_player) }.to raise_error(Checkers::Movement::OutOfTurn)
        end
      end
    end
  end
end