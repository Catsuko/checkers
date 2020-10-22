require_relative 'checkers/out_of_bounds'
require_relative 'checkers/movement/out_of_turn'
require_relative 'checkers/movement/illegal_move'

Dir[File.join(__dir__, 'checkers', 'services', '*.rb')].sort.each { |file| require file }
