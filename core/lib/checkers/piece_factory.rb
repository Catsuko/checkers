require_relative 'piece'
require_relative 'movement/diagonal_move'
require_relative 'movement/composite_move'

module Checkers
  class PieceFactory
    def create_light_piece(id)
      Piece.new(id, light: true, movement: light_movement)
    end

    def create_dark_piece(id)
      Piece.new(id, light: false, movement: dark_movement)
    end

    def create_from(piece_attributes)
      factory_method = piece_attributes.fetch(:light, false) ? :create_light_piece : :create_dark_piece
      piece = send(factory_method, piece_attributes.fetch(:id, nil))
      piece_attributes.fetch(:is_king, false) ? piece.promote : piece
    end

    private

    def light_movement
      @light_movement ||= standard_piece_movement(:bottom)
    end

    def dark_movement
      @dark_movement ||= standard_piece_movement(:top)
    end
    
    def standard_piece_movement(vertical_direction)
      Checkers::Movement::CompositeMove.new([
        Checkers::Movement::DiagonalMove.new(x_dir: :left, y_dir: vertical_direction),
        Checkers::Movement::DiagonalMove.new(x_dir: :right, y_dir: vertical_direction)
      ])
    end
  end
end