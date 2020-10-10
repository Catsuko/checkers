require 'spec_helper'
require 'checkers'
require 'support/shared_contexts/game_context'
require 'checkers/movement/illegal_move'

RSpec.describe Checkers::Game do
  describe 'when a player moves their piece,' do
    include_context('game')

    let(:target_piece_color) { :dark }
    let(:target_piece_position) { Checkers::Position.new(0, 0) }

    subject { game.move(target_piece, to: move_position) }

    context 'given the position to move to is an available move,' do
      let(:move_position) { target_piece_position.top_right }

      it 'the piece is placed at the move position' do
        expect(subject.space_occupied?(move_position)).to be true
      end

      it 'the turn is changed to the next player' do
        expect(subject.current_player).to eq second_player
      end
    end

    context 'given the position to move is not an available move,' do
      let(:move_position) { target_piece_position.top_right.top_right.top_right }

      it 'an Illegal Move error is raised' do
        expect{ subject }.to raise_error(Checkers::Movement::IllegalMove)
      end
    end
  end
end