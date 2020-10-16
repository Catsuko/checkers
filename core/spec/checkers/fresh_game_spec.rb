require 'spec_helper'
require 'checkers/player'
require 'checkers/game_factory'

RSpec.describe Checkers::GameFactory do
  describe 'when creating a fresh game of checkers' do
    let(:first_player) { Checkers::Player.new('player 1') }
    let(:second_player) { Checkers::Player.new('player 2') }

    subject { Checkers::GameFactory.new.fresh(first_player, second_player) }

    it { is_expected.not_to be_finished }

    it 'the first player takes the first turn' do
      expect(subject.current_player).to eq first_player
    end

    it 'the twelve closest squares to the first player are occupied by dark pieces' do
      positions = 4.times.reduce([]) do |arr, n|
        arr << (arr[-2]&.bottom_left || Checkers::Position.new(0, 0))
        arr << arr[-1].top_right
        arr << arr[-1].top_left
        arr
      end

      dark_pieces = positions.map{|p| subject.space_occupied?(p){|piece| !piece.light?}}
      expect(dark_pieces).to all(be true)
    end

    it 'the twelve closest squares to the second player are occupied by light pieces' do
      positions = 4.times.reduce([]) do |arr, n|
        arr << (arr[-2]&.top_left || Checkers::Position.new(7, 7))
        arr << arr[-1].bottom_left
        arr << arr[-1].bottom_right
        arr
      end

      light_pieces = positions.map{|p| subject.space_occupied?(p){|piece| piece.light?}}
      expect(light_pieces).to all(be true)
    end
  end
end