require 'spec_helper'
require 'checkers'
require 'checkers/movement/illegal_move'
require 'support/shared_contexts/game_context'

RSpec.describe Checkers::Game do
  describe 'when a player moves a piece that belongs to their opponent,' do
    include_context('game')

    let(:target_piece_position) { Checkers::Movement::Position.new(1, 1) }
    let(:target_piece_color) { :light }

    it 'an Illegal Move error is raised' do
      expect{ game.move(target_piece, to: target_piece_position, by: first_player) }.to raise_error(Checkers::Movement::IllegalMove)
    end
  end
end