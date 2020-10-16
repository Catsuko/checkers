require 'spec_helper'
require 'support/shared_contexts/game_context'
require 'checkers'

RSpec.describe Checkers::Game do
  describe 'when a normal piece reaches the other end of the board,' do
    include_context('game')

    subject { game.move(target_piece, to: king_position) }

    context 'given a dark piece,' do
      let(:target_piece_color) { :dark }
      let(:target_piece_position) { Checkers::Position.new(6, 6) }
      let(:king_position) { target_piece_position.top_left }

      it 'the piece becomes a king,' do
        subject.space_occupied?(king_position) do |piece|
          expect(piece).to be_king
        end
      end
    end

    context 'given a light piece,' do
      let(:turn) { Checkers::Turn.new(first_player: first_player, second_player: second_player).next }
      let(:target_piece_color) { :light }
      let(:target_piece_position) { Checkers::Position.new(1, 1) }
      let(:king_position) { target_piece_position.bottom_left }

      it 'the piece becomes a king,' do
        subject.space_occupied?(king_position) do |piece|
          expect(piece).to be_king
        end
      end
    end

    context 'given there is a possible jump above promotion,' do
      let(:target_piece_color) { :dark }
      let(:target_piece_position) { Checkers::Position.new(4, 6) }
      let(:king_position) { target_piece_position.top_left }
      let(:light_pieces) { king_position.bottom_left }

      it 'the turn is ended after the piece becomes king,' do
        expect(subject.current_player).to eq second_player
      end
    end
  end
end