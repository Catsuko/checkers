require 'spec_helper'
require 'checkers'
require 'checkers/movement/illegal_move'
require 'support/shared_contexts/game_context'

RSpec.describe Checkers::Game do
  describe 'when moving pieces,' do
    include_context('game')
    let(:position) { Checkers::Movement::Position.new(1, 1) }

    context "given the player tries to move their opponent's piece," do
      let(:piece) { Checkers::Piece.new('id', light: true) }
      it 'an Illegal Move error is raised' do
        expect{ game.move(piece, to: position, by: first_player) }.to raise_error(Checkers::Movement::IllegalMove)
      end
    end
  end
end