
require 'spec_helper'
require 'checkers'
require 'support/shared_contexts/game_context'

RSpec.shared_examples 'game is not finished' do
  it 'the game is not finished' do
    expect(game).not_to be_finished
  end

  it 'there is neither a winner nor a loser' do
    expect{ |b| game.finished?(&b) }.not_to yield_control
  end
end

RSpec.shared_examples 'game is finished' do 
  it 'the game is finished' do
    expect(game).to be_finished
  end
end

RSpec.describe Checkers::Game do
  describe 'when checking if a game is finished,' do
    include_context('game')

    context 'given the first player can make a move on their turn,' do
      let(:dark_pieces) { Checkers::Movement::Position.new(1, 1) }

      include_examples 'game is not finished'
    end

    context 'given the second player can make a move on their turn,' do
      let(:turn) { Checkers::Turn.new(first_player: first_player, second_player: second_player).next }
      let(:light_pieces) { Checkers::Movement::Position.new(5, 5) }

      include_examples 'game is not finished'
    end

    context 'given the first player cannot make a move on their turn,' do
      let(:dark_pieces) { Checkers::Movement::Position.new(7, 7) }

      include_examples 'game is finished'

      it 'the first player is the loser' do
        expect{ |b| game.finished?(&b) }.to yield_with_args(Checkers::Player, first_player)
      end

      it 'the second player is the winner' do
        expect{ |b| game.finished?(&b) }.to yield_with_args(second_player, Checkers::Player)
      end
    end

    context 'given the second player cannot make a move on their turn,' do
      let(:turn) { Checkers::Turn.new(first_player: first_player, second_player: second_player).next }
      let(:light_pieces) { Checkers::Movement::Position.new(0, 0) }

      include_examples 'game is finished'

      it 'the first player is the winner' do
        expect{ |b| game.finished?(&b) }.to yield_with_args(first_player, Checkers::Player)
      end

      it 'the second player is the loser' do
        expect{ |b| game.finished?(&b) }.to yield_with_args(Checkers::Player, second_player)
      end
    end
  end
end