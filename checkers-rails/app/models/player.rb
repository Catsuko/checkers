class Player < ApplicationRecord
  with_options class_name: 'Game' do
    has_many :games_going_first, foreign_key: 'first_player_id'
    has_many :games_going_second, foreign_key: 'second_player_id'
  end

  def to_s
    nickname
  end
end