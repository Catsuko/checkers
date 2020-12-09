class Game < ApplicationRecord
  has_one :turn
  belongs_to :jumping_piece, class_name: 'Piece', optional: true
  with_options class_name: 'Player' do
    belongs_to :first_player
    belongs_to :second_player
  end
  has_many :pieces

  def self.store(attributes)
    Game.create! do |game|
      game.first_player = Player.find_or_initialize_by(nickname: attributes[:first_player_id])
      game.second_player = Player.find_or_initialize_by(nickname: attributes[:second_player_id])
      game.build_turn(number: attributes.dig(:turn, :number))
      attributes[:pieces].each do |position, piece|
        game.pieces.build(position: position, in_game_id: piece[:id], light: piece[:light], is_king: piece[:is_king])
      end
    end
  end

  def self.generate_id
    Game.maximum(:id).to_i.next
  end
end