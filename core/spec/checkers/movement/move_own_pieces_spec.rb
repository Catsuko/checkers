require 'spec_helper'
require 'checkers'
require 'checkers/movement/illegal_move'

RSpec.describe Checkers::Game do
  describe 'when moving pieces,' do
    let(:first_player) { Checkers::Player.new('Player 1') }
    let(:second_player) { Checkers::Player.new('Player 2') }
    let(:turn) { Checkers::Turn.new(first_player: first_player, second_player: second_player) }
    let(:game) { Checkers::Game.new({ piece => Checkers::Movement::Position.new(0, 0) }, turn: turn) }
    let(:to) { Checkers::Movement::Position.new(1, 1) }

    context "given the player tries to move their opponent's piece," do
      let(:piece) { Checkers::Piece.new('id', light: true) }
      it 'an Illegal Move error is raised' do
        expect{ game.move(piece, to: to, by: first_player) }.to raise_error(Checkers::Movement::IllegalMove)
      end
    end
  end
end