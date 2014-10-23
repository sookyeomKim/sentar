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

ActiveRecord::Schema.define(version: 20141023162916) do

  create_table "bulletins", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "post_type",   default: "bulletin"
    t.integer  "user_id"
    t.integer  "shelter_id"
  end

  add_index "bulletins", ["shelter_id"], name: "index_bulletins_on_shelter_id"
  add_index "bulletins", ["user_id"], name: "index_bulletins_on_user_id"

  create_table "cart_items", force: true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "quantity"
    t.integer  "item_id"
    t.string   "item_type"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id"

  create_table "likes", force: true do |t|
    t.integer  "micropost_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "micropost_comments", force: true do |t|
    t.string   "user_name"
    t.text     "content"
    t.integer  "micropost_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "microposts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
    t.string   "title"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bulletin_id"
    t.string   "picture"
  end

  add_index "posts", ["bulletin_id"], name: "index_posts_on_bulletin_id"

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
    t.string   "picture2"
    t.string   "picture3"
    t.text     "content"
    t.string   "category"
  end

  add_index "products", ["user_id", "created_at"], name: "index_products_on_user_id_and_created_at"

  create_table "purchases", force: true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.string   "receive_name"
    t.string   "addr"
    t.string   "phone"
    t.string   "memo"
    t.integer  "total_cost"
    t.string   "trade_type"
    t.string   "payer"
    t.integer  "status"
    t.integer  "ship_cost"
    t.string   "ship_company"
    t.string   "trans_num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owener_id"
  end

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "shelters", force: true do |t|
    t.string   "name"
    t.string   "introduce"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "tmap_id"
    t.string   "kind"
    t.string   "lonlat"
  end

  add_index "shelters", ["user_id"], name: "index_shelters_on_user_id"

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "tmaps", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
