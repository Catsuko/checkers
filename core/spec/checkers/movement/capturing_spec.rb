require 'support/shared_contexts/game_context'
require 'checkers'

RSpec.describe Checkers::Game do
  describe 'when one piece jumps over another piece,' do
    include_context('game')

    let(:target_piece_position) { Checkers::Position.new(4, 4) }
    let(:target_piece_color) { :dark }
    let(:light_pieces) { target_piece_position.top_right }

    it 'the piece that was jumped over is removed from the game' do
      after_jump = game.move(target_piece, to: target_piece_position.top_right.top_right)
      expect(after_jump.space_occupied?(light_pieces)).to be false
    end
  end
end