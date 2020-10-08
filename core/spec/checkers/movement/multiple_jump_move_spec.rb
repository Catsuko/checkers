require 'spec_helper'
require 'support/shared_contexts/game_context'
require 'checkers'

=begin
  Multiple jump move: Within one turn, a player can make a multiple jump
  move with the same piece by jumping from vacant dark square to
  vacant dark square. The player must capture one of the opponent's
  pieces with each jump. The player can capture several pieces
  with a move of several jumps.
=end

RSpec.describe Checkers::Game do
  describe 'when getting the available moves for a piece,' do
    include_context('game')

    context 'given a dark piece,' do
      let(:target_piece_color) { :dark }
    end

    context 'given a light piece,' do
      let(:target_piece_color) { :light }
    end
  end
end
