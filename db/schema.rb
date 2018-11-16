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

ActiveRecord::Schema.define(version: 20181107203036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contexts", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.string   "category"
    t.string   "code"
    t.string   "code_system_oid"
    t.string   "code_system_name"
    t.string   "term"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["item_id"], name: "index_contexts_on_item_id", using: :btree
    t.index ["item_type"], name: "index_contexts_on_item_type", using: :btree
  end

  create_table "document_file_types", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.string   "mime_type"
    t.string   "extension"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_files", force: :cascade do |t|
    t.integer  "document_id"
    t.string   "name"
    t.integer  "document_file_type_id"
    t.binary   "content"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.datetime "deleted_at"
    t.json     "properties"
    t.index ["deleted_at"], name: "index_document_files_on_deleted_at", using: :btree
    t.index ["document_file_type_id"], name: "index_document_files_on_document_file_type_id", using: :btree
    t.index ["document_id"], name: "index_document_files_on_document_id", using: :btree
  end

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "institution"
    t.boolean  "is_template",          default: false
    t.integer  "status_id",                            null: false
    t.integer  "visibility_id",                        null: false
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "deleted_by_id"
    t.integer  "folder_id"
    t.integer  "template_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.datetime "deleted_at"
    t.json     "style"
    t.integer  "clone_source_id"
    t.integer  "template_version"
    t.integer  "clone_source_version"
    t.json     "display_format"
    t.index ["clone_source_id"], name: "index_documents_on_clone_source_id", using: :btree
    t.index ["created_by_id"], name: "index_documents_on_created_by_id", using: :btree
    t.index ["deleted_at"], name: "index_documents_on_deleted_at", using: :btree
    t.index ["deleted_by_id"], name: "index_documents_on_deleted_by_id", using: :btree
    t.index ["folder_id"], name: "index_documents_on_folder_id", using: :btree
    t.index ["is_template"], name: "index_documents_on_is_template", using: :btree
    t.index ["status_id"], name: "index_documents_on_status_id", using: :btree
    t.index ["template_id"], name: "index_documents_on_template_id", using: :btree
    t.index ["updated_by_id"], name: "index_documents_on_updated_by_id", using: :btree
    t.index ["visibility_id"], name: "index_documents_on_visibility_id", using: :btree
  end

  create_table "folders", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "status_id"
    t.integer  "visibility_id"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "deleted_by_id"
    t.integer  "parent"
    t.integer  "owner"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_folders_on_deleted_at", using: :btree
    t.index ["status_id"], name: "index_folders_on_status_id", using: :btree
    t.index ["visibility_id"], name: "index_folders_on_visibility_id", using: :btree
  end

  create_table "sections", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "content"
    t.integer  "status_id"
    t.integer  "visibility_id"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "deleted_by_id"
    t.integer  "document_id"
    t.integer  "order"
    t.integer  "template_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.datetime "deleted_at"
    t.integer  "template_version"
    t.integer  "clone_source_id"
    t.integer  "clone_source_version"
    t.json     "display_format"
    t.index ["deleted_at"], name: "index_sections_on_deleted_at", using: :btree
    t.index ["document_id"], name: "index_sections_on_document_id", using: :btree
    t.index ["status_id"], name: "index_sections_on_status_id", using: :btree
    t.index ["template_id"], name: "index_sections_on_template_id", using: :btree
    t.index ["visibility_id"], name: "index_sections_on_visibility_id", using: :btree
  end

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
    t.string   "first_name"
    t.string   "last_name"
    t.string   "institution"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

  create_table "visibilities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "document_files", "document_file_types"
  add_foreign_key "document_files", "documents"
  add_foreign_key "documents", "folders"
  add_foreign_key "documents", "statuses"
  add_foreign_key "documents", "visibilities"
  add_foreign_key "folders", "statuses"
  add_foreign_key "folders", "visibilities"
  add_foreign_key "sections", "documents"
  add_foreign_key "sections", "statuses"
  add_foreign_key "sections", "visibilities"
end
