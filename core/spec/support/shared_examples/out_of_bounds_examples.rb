require 'checkers/movement/out_of_bounds'

RSpec.shared_examples 'out of bounds position' do
  it 'an Out of Bounds error is raised' do
    expect{ subject }.to raise_error(Checkers::Movement::OutOfBounds)
  end
end