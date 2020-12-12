class Piece < ApplicationRecord
  belongs_to :game

  def self.map_to_lookup
    all.reduce({}) do |hash, piece|
      hash.update(piece.position => piece.to_h)
    end
  end

  def to_h
    {
      id: in_game_id.to_i,
      is_king: is_king,
      light: light
    }
  end
end