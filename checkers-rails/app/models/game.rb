class Game < ApplicationRecord
  has_one :turn, dependent: :destroy
  belongs_to :jumping_piece, class_name: 'Piece', optional: true
  with_options class_name: 'Player' do
    belongs_to :first_player
    belongs_to :second_player
  end
  has_many :pieces, dependent: :delete_all

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

  def self.get(game_id)
    Game.find(game_id).to_h
  end

  def self.save(attributes)
    game = Game.find(attributes.fetch(:id))
    Game.transaction do
      jumping_piece = Piece.find_by(game_id: game.id, in_game_id: attributes.dig(:jumping_piece, :id))
      game.turn.update!(number: attributes.dig(:turn, :number))
      game.update!(jumping_piece: jumping_piece)
      piece_attributes = attributes.fetch(:pieces)
      attributes_by_id = attributes.fetch(:pieces).reduce({}) do |hash, (pos, piece)|
        hash.update(piece[:id] => piece.slice(:is_king).merge(position: pos))
      end
      game.pieces.each do |piece|
        if attributes_by_id.key?(piece.in_game_id.to_i)
          piece.update!(**attributes_by_id[piece.in_game_id.to_i])
        else
          piece.destroy!
        end
      end
    end
  end

  # TODO: This should not be exposed to the domain
  def self.generate_id
    Game.maximum(:id).to_i.next
  end

  def squares
    piece_map = pieces.reduce({}) { |map, piece| map.update(piece.position => piece) }
    64.times.map do |n|
      yield(n, piece_map[n]) if block_given?
      piece_map[n]
    end
  end

  def to_h
    {
      first_player_id: first_player.nickname,
      second_player_id: second_player.nickname,
      turn: { number: turn.number },
      jumping_piece: jumping_piece&.in_game_id&.to_i,
      pieces: pieces.map_to_lookup
    }
  end
end