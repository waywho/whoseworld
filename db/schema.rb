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

ActiveRecord::Schema[7.2].define(version: 2025_01_06_213220) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "burm_musicals", force: :cascade do |t|
    t.string "title"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string "location"
    t.decimal "fee", precision: 8, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_burm_musicals_on_slug", unique: true
  end

  create_table "burm_people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "burm_roles", force: :cascade do |t|
    t.string "name"
    t.bigint "burm_musical_id", null: false
    t.integer "voice_type"
    t.integer "role_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["burm_musical_id"], name: "index_burm_roles_on_burm_musical_id"
  end

  create_table "burm_signups", force: :cascade do |t|
    t.bigint "burm_person_id"
    t.bigint "burm_role_id"
    t.bigint "burm_musical_id"
    t.bigint "alternative_role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "musical_title"
    t.string "person_name"
    t.string "role_name"
    t.index ["burm_musical_id"], name: "index_burm_signups_on_burm_musical_id"
    t.index ["burm_person_id"], name: "index_burm_signups_on_burm_person_id"
    t.index ["burm_role_id"], name: "index_burm_signups_on_burm_role_id"
  end

  create_table "contents", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "heading"
    t.string "summary"
    t.integer "row_order"
    t.string "contentable_type"
    t.bigint "contentable_id"
    t.index ["contentable_type", "contentable_id"], name: "index_contents_on_contentable_type_and_contentable_id"
    t.index ["contentable_type"], name: "index_contents_on_contentable_type"
  end

  create_table "domain_aliases", force: :cascade do |t|
    t.string "domain"
    t.string "subdomain"
    t.bigint "site_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_domain_aliases_on_site_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "galleries", force: :cascade do |t|
    t.string "description"
    t.bigint "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.boolean "feature", default: false, null: false
    t.integer "row_order"
    t.index ["page_id"], name: "index_galleries_on_page_id"
  end

  create_table "medias", force: :cascade do |t|
    t.string "title"
    t.text "source"
    t.bigint "page_id", null: false
    t.bigint "site_id"
    t.integer "row_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "media_type", null: false
    t.index ["page_id"], name: "index_medias_on_page_id"
    t.index ["site_id"], name: "index_medias_on_site_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.bigint "site_id", null: false
    t.integer "row_order"
    t.integer "template", default: 0, null: false
    t.integer "kind"
    t.index ["kind", "site_id"], name: "index_pages_on_kind_and_site_id"
    t.index ["site_id", "title"], name: "index_pages_on_site_id_and_title", unique: true
    t.index ["site_id"], name: "index_pages_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "domain"
    t.string "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "subtitle"
    t.boolean "public", default: false
    t.integer "nav_position", default: 0, null: false
    t.integer "layout_style", default: 0, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin"], name: "index_users_on_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "burm_roles", "burm_musicals"
  add_foreign_key "burm_signups", "burm_musicals"
  add_foreign_key "burm_signups", "burm_people"
  add_foreign_key "burm_signups", "burm_roles"
  add_foreign_key "domain_aliases", "sites"
  add_foreign_key "galleries", "pages"
  add_foreign_key "medias", "pages"
  add_foreign_key "medias", "sites"
  add_foreign_key "pages", "sites"
end
