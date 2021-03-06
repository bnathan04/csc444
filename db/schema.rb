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

ActiveRecord::Schema.define(version: 2018_12_03_203611) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "interactions", force: :cascade do |t|
    t.integer "person_id"
    t.datetime "date"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.integer "item_id"
    t.index ["item_id"], name: "index_interactions_on_item_id"
    t.index ["person_id"], name: "index_interactions_on_person_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "category"
    t.string "status"
    t.string "owner"
    t.string "current_holder"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_id"
    t.index ["person_id"], name: "index_items_on_person_id"
  end

  create_table "items_tags", id: false, force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "tag_id", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.float "rating"
    t.string "street"
    t.string "city"
    t.string "province"
    t.string "country"
    t.string "postal_code"
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.integer "reviews_id"
    t.index ["reviews_id"], name: "index_people_on_reviews_id"
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.string "complaint"
    t.integer "reporter"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "resolved", default: false
    t.index ["person_id"], name: "index_reports_on_person_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "comment"
    t.float "rating"
    t.integer "interaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_id"
    t.integer "reviewer"
    t.index ["interaction_id"], name: "index_reviews_on_interaction_id"
    t.index ["person_id"], name: "index_reviews_on_person_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false
    t.boolean "locked", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
