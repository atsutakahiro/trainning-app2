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

ActiveRecord::Schema.define(version: 20230407023511) do

  create_table "repeats", force: :cascade do |t|
    t.integer "sets"
    t.text "remark"
    t.integer "train_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "set_number"
    t.index ["train_id"], name: "index_repeats_on_train_id"
  end

  create_table "trains", force: :cascade do |t|
    t.string "exercise"
    t.string "note"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "part"
    t.integer "weight"
    t.integer "rep"
    t.string "name"
    t.integer "sets"
    t.string "chest_exercises"
    t.string "shoulder_exercises"
    t.string "biceps_exercises"
    t.string "triceps_exercises"
    t.string "abdominal_exercises"
    t.string "back_exercises"
    t.string "reg_exercises"
    t.string "exercises"
    t.integer "set_num"
    t.index ["user_id"], name: "index_trains_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
