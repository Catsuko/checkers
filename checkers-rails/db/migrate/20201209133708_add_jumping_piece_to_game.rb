class AddJumpingPieceToGame < ActiveRecord::Migration[6.0]
  def change
    add_reference :games, :jumping_piece, foreign_key: { to_table: :pieces }
  end
end
