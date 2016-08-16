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

ActiveRecord::Schema.define(version: 20160816124940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "status_id"
    t.integer  "visibility_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "deleted_by"
    t.integer  "folder_id"
    t.integer  "template"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "deleted_at"
  end

  add_index "articles", ["created_by"], name: "index_articles_on_created_by", using: :btree
  add_index "articles", ["deleted_at"], name: "index_articles_on_deleted_at", using: :btree
  add_index "articles", ["deleted_by"], name: "index_articles_on_deleted_by", using: :btree
  add_index "articles", ["folder_id"], name: "index_articles_on_folder_id", using: :btree
  add_index "articles", ["status_id"], name: "index_articles_on_status_id", using: :btree
  add_index "articles", ["template"], name: "index_articles_on_template", using: :btree
  add_index "articles", ["updated_by"], name: "index_articles_on_updated_by", using: :btree
  add_index "articles", ["visibility_id"], name: "index_articles_on_visibility_id", using: :btree

  create_table "folders", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "status_id"
    t.integer  "visibility_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "deleted_by"
    t.integer  "parent"
    t.integer  "owner"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "deleted_at"
  end

  add_index "folders", ["deleted_at"], name: "index_folders_on_deleted_at", using: :btree
  add_index "folders", ["status_id"], name: "index_folders_on_status_id", using: :btree
  add_index "folders", ["visibility_id"], name: "index_folders_on_visibility_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "status_id"
    t.integer  "visibility_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "deleted_by"
    t.integer  "article_id"
    t.integer  "order"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "deleted_at"
  end

  add_index "sections", ["article_id"], name: "index_sections_on_article_id", using: :btree
  add_index "sections", ["deleted_at"], name: "index_sections_on_deleted_at", using: :btree
  add_index "sections", ["status_id"], name: "index_sections_on_status_id", using: :btree
  add_index "sections", ["visibility_id"], name: "index_sections_on_visibility_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "visibilities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "articles", "folders"
  add_foreign_key "articles", "statuses"
  add_foreign_key "articles", "visibilities"
  add_foreign_key "folders", "statuses"
  add_foreign_key "folders", "visibilities"
  add_foreign_key "sections", "articles"
  add_foreign_key "sections", "statuses"
  add_foreign_key "sections", "visibilities"
end
