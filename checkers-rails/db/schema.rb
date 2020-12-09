# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_09_142545) do

  create_table "games", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "first_player_id", null: false
    t.bigint "second_player_id", null: false
    t.bigint "jumping_piece_id"
    t.index ["first_player_id"], name: "index_games_on_first_player_id"
    t.index ["jumping_piece_id"], name: "index_games_on_jumping_piece_id"
    t.index ["second_player_id"], name: "index_games_on_second_player_id"
  end

  create_table "pieces", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "position", null: false
    t.boolean "light", null: false
    t.boolean "is_king", default: false, null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "in_game_id", null: false
    t.index ["game_id", "in_game_id"], name: "index_pieces_on_game_id_and_in_game_id", unique: true
    t.index ["game_id", "position"], name: "index_pieces_on_game_id_and_position", unique: true
    t.index ["game_id"], name: "index_pieces_on_game_id"
  end

  create_table "players", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "nickname", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nickname"], name: "index_players_on_nickname", unique: true
  end

  create_table "turns", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "number", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_turns_on_game_id"
  end

  add_foreign_key "games", "pieces", column: "jumping_piece_id"
  add_foreign_key "games", "players", column: "first_player_id"
  add_foreign_key "games", "players", column: "second_player_id"
end
