class AddInGameIdToPieces < ActiveRecord::Migration[6.0]
  def change
    add_column :pieces, :in_game_id, :string, null: false
    add_index :pieces, [:game_id, :in_game_id], unique: true
  end
end
