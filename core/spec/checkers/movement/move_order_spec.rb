require 'spec_helper'
require 'checkers'
require 'checkers/movement/out_of_turn'
require 'support/shared_contexts/game_context'

RSpec.describe Checkers::Game do
  describe 'when taking turns to move pieces,' do
    include_context('game')
    let(:target_piece_position) { Checkers::Movement::Position.new(4, 4) }

    (1..5).each do |n|
      context "given the player is going #{n % 2 == 0 ? 'first' : 'second'} and it is turn #{n}," do
        let(:turn_number) { n }
        let(:target_piece_color) { turn.even? ? :dark : :light }
        let(:move_position) { turn.even? ? target_piece_position.top_right : target_piece_position.bottom_right }

        it 'an Out of Turn error is raised' do 
          expect{ game.move(target_piece, to: move_position, by: turn.waiting_player) }.to raise_error(Checkers::Movement::OutOfTurn)
        end
      end
    end
  end
end