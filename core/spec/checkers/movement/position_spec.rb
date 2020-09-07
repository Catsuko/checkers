require 'spec_helper'
require 'checkers'
require 'shared_examples/out_of_bounds_examples'

RSpec.describe Checkers::Movement::Position do
    let(:x) { 0 }
    let(:y) { 0 }
    subject { Checkers::Movement::Position.new(x, y) }

    # TODO: Would be nice to use a properties based testing style here.
    [-1, 8, 10].each do |n|
        context "given the x coordinate is #{n}" do
            let(:x) { n }
            include_examples 'out of bounds position'
        end

        context "given the y coordinate is #{n}" do
            let(:y) { n }
            include_examples 'out of bounds position'
        end
    end

    context 'given the coordinates are within the range of the game,' do
        it 'a position is created' do
            expect{ subject }.not_to raise_error
        end
    end

    context 'given two positions at the same coordinates,' do
        let(:a) { Checkers::Movement::Position.new(x, y) }
        let(:b) { Checkers::Movement::Position.new(x, y) }

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