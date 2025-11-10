# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_11_10_025222) do
  create_table "breeds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dog_traits", force: :cascade do |t|
    t.integer "dog_id", null: false
    t.integer "trait_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dog_id"], name: "index_dog_traits_on_dog_id"
    t.index ["trait_id"], name: "index_dog_traits_on_trait_id"
  end

  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.integer "owner_id", null: false
    t.integer "sub_breed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_dogs_on_owner_id"
    t.index ["sub_breed_id"], name: "index_dogs_on_sub_breed_id"
  end

  create_table "dogs_traits", force: :cascade do |t|
    t.integer "dog_id", null: false
    t.integer "trait_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dog_id"], name: "index_dogs_traits_on_dog_id"
    t.index ["trait_id"], name: "index_dogs_traits_on_trait_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "url"
    t.integer "sub_breed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sub_breed_id"], name: "index_images_on_sub_breed_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_breeds", force: :cascade do |t|
    t.string "name"
    t.integer "breed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["breed_id"], name: "index_sub_breeds_on_breed_id"
  end

  create_table "traits", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "dog_traits", "dogs"
  add_foreign_key "dog_traits", "traits"
  add_foreign_key "dogs", "owners"
  add_foreign_key "dogs", "sub_breeds"
  add_foreign_key "dogs_traits", "dogs"
  add_foreign_key "dogs_traits", "traits"
  add_foreign_key "images", "sub_breeds"
  add_foreign_key "sub_breeds", "breeds"
end
