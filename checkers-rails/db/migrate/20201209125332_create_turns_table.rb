class CreateTurnsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :turns do |t|
      t.integer :number, null: false
      t.references :game, index: true, null: false
      t.timestamps
    end
  end
end
