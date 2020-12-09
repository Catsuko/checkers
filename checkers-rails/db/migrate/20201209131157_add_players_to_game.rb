class AddPlayersToGame < ActiveRecord::Migration[6.0]
  def change
    with_options foreign_key: { to_table: :players }, null: false do
      add_reference :games, :first_player
      add_reference :games, :second_player
    end
  end
end
