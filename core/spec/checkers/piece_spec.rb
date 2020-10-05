require 'spec_helper'
require 'checkers'

RSpec.describe Checkers::Piece do
  describe 'when checking if the piece can move on given turn,' do
    let(:piece) { Checkers::Piece.regular(1, light: is_light) }
    let(:even_turn) { Checkers::Turn.new(2, first_player: nil, second_player: nil) }

    context 'given a light piece,' do
      let(:is_light) { true } 

      it 'the piece can move on even turns' do
        expect(piece.own?(even_turn)).to be true
      end

      it 'the piece cannot move on odd turns' do
        expect(piece.own?(even_turn.next)).to be false
      end
    end

    context 'given a dark piece,' do
      let(:is_light) { false }
      
      it 'the piece cannot move on even turns' do
        expect(piece.own?(even_turn)).to be false
      end

      it 'the piece can move on odd turns' do
        expect(piece.own?(even_turn.next)).to be true
      end
    end
  end

  describe 'when checking equality,' do
    context 'given two pieces with the same id,' do
      let(:a) { Checkers::Piece.regular('same', light: true) }
      let(:b) { Checkers::Piece.regular('same', light: true) }
  
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