require 'spec_helper'
require 'support/shared_contexts/game_context'
require 'checkers'

RSpec.describe Checkers::Game do
  describe 'when jumping one piece over another,' do
    include_context('game')

    let(:target_piece_color) { :dark }
    let(:target_piece_position) { Checkers::Position.new(0, 0) }

    context 'given a second jump can be made afterwards,' do
      let(:light_pieces) { [target_piece_position.top_right, target_piece_position.top_right.top_right.top_right] }

      it 'the turn is not passed to the other player' do
        after_jump = game.move(target_piece, to: target_piece_position.top_right.top_right)
        expect(after_jump.current_player).to eq game.current_player
      end
    end

    context 'given there are no further jumps available,' do
      let(:light_pieces) { target_piece_position.top_right }

      it 'the turn is passed to the other player' do
        after_jump = game.move(target_piece, to: target_piece_position.top_right.top_right)
        expect(after_jump.current_player).not_to eq game.current_player
      end
    end
  end
end
