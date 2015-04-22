# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150422062845) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_stats", id: false, force: :cascade do |t|
    t.string   "game_id"
    t.string   "player_id"
    t.integer  "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "game_stats", ["game_id", "player_id"], name: "index_game_stats_on_game_id_and_player_id", unique: true, using: :btree

  create_table "game_summaries", id: false, force: :cascade do |t|
    t.string   "id",        null: false
    t.string   "title"
    t.string   "status"
    t.string   "coverage"
    t.datetime "scheduled"
    t.string   "clock"
    t.integer  "quarter"
  end

  add_index "game_summaries", ["id"], name: "index_game_summaries_on_id", unique: true, using: :btree

  create_table "games", id: false, force: :cascade do |t|
    t.string   "id",           null: false
    t.string   "title"
    t.string   "status"
    t.string   "coverage"
    t.datetime "scheduled"
    t.string   "series_id"
    t.string   "home_team_id"
    t.string   "away_team_id"
  end

  add_index "games", ["away_team_id"], name: "index_games_on_away_team_id", using: :btree
  add_index "games", ["home_team_id"], name: "index_games_on_home_team_id", using: :btree
  add_index "games", ["id"], name: "index_games_on_id", unique: true, using: :btree
  add_index "games", ["series_id"], name: "index_games_on_series_id", using: :btree

  create_table "players", id: false, force: :cascade do |t|
    t.string  "id",                       null: false
    t.string  "first_name"
    t.string  "last_name"
    t.string  "position"
    t.string  "primary_position"
    t.string  "jersey_number"
    t.integer "fantasy_draft_manager_id"
  end

  add_index "players", ["fantasy_draft_manager_id"], name: "index_players_on_fantasy_draft_manager_id", using: :btree
  add_index "players", ["id"], name: "index_players_on_id", unique: true, using: :btree

  create_table "series", id: false, force: :cascade do |t|
    t.string  "id",         null: false
    t.string  "title"
    t.string  "status"
    t.date    "start_date"
    t.integer "round"
  end

  add_index "series", ["id"], name: "index_series_on_id", unique: true, using: :btree

  create_table "teams", id: false, force: :cascade do |t|
    t.string "id",         null: false
    t.string "name"
    t.string "alias_name"
    t.string "market"
  end

  add_index "teams", ["id"], name: "index_teams_on_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",              default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
