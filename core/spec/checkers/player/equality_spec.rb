require 'spec_helper'
require 'checkers'

RSpec.describe Checkers::Player do
  describe 'when checking equality,' do
    context 'given two players with the same id,' do
      let(:a) { Checkers::Player.new('player') }
      let(:b) { Checkers::Player.new('player') }
  
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