require 'spec_helper'
require 'checkers'

RSpec.describe Checkers::Piece do
    describe 'when checking piece ownership,' do
        %i[player_a player_b].each do |sym|
            let(sym) { Checkers::Player.new(sym.to_s) }
        end
        
        context 'given the player owns the piece' do
            subject { Checkers::Piece.new(1, owner: player_a).owned_by?(player_a) }

            it { is_expected.to be true }
        end

        context 'given the player does not own the piece' do
            subject { Checkers::Piece.new(1, owner: player_a).owned_by?(player_b) }

            it { is_expected.to be false }
        end
    end

    describe 'when checking equality,' do
        context 'given two pieces with the same id,' do
            let(:a) { Checkers::Piece.new('same', owner: Checkers::Player.new('player')) }
            let(:b) { Checkers::Piece.new('same', owner: Checkers::Player.new('player')) }
    
            it 'they are considered equal using ==' do
                expect(a == b).to be true
            end
    
            it 'they are considered equal using eql?' do
                expect(a.eql?(b)).to be true
            end
    
            it 'they are considered equal as a hash key' do
                hash = { a => true }
                expect(hash.key?(b)).to be true
            end
        end
    end
end