class CreatePiecesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :pieces do |t|
      t.integer :position, null: false
      t.boolean :light, null: false
      t.boolean :is_king, default: false, null: false
      t.references :game, null: false
      t.index [:game_id, :position], unique: true
      t.timestamps
    end
  end
end
