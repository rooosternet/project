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

ActiveRecord::Schema.define(version: 20160801073710) do

  create_table "attachments", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.string   "attachment",      limit: 255
    t.string   "attachment_type", limit: 255
    t.string   "description",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "in_messages", force: :cascade do |t|
    t.integer  "from_id",    limit: 4,     default: 0,     null: false
    t.integer  "to_id",      limit: 4,     default: 0,     null: false
    t.text     "note",       limit: 65535
    t.string   "token",      limit: 255
    t.boolean  "notify",                   default: false, null: false
    t.boolean  "private",                  default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "subject",    limit: 255
    t.integer  "parent_id",  limit: 4
    t.text     "archive",    limit: 65535
  end

  add_index "in_messages", ["from_id"], name: "index_in_messages_on_from_id", using: :btree
  add_index "in_messages", ["parent_id"], name: "index_in_messages_on_parent_id", using: :btree
  add_index "in_messages", ["subject"], name: "index_in_messages_on_subject", using: :btree
  add_index "in_messages", ["to_id"], name: "index_in_messages_on_to_id", using: :btree
  add_index "in_messages", ["token"], name: "index_in_messages_on_token", using: :btree

  create_table "profile_connects", force: :cascade do |t|
    t.integer  "profile_id",       limit: 4
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.string   "name",             limit: 255
    t.string   "email",            limit: 255
    t.string   "nickname",         limit: 255
    t.string   "first_name",       limit: 255
    t.string   "last_name",        limit: 255
    t.string   "location",         limit: 255
    t.string   "description",      limit: 255
    t.string   "image",            limit: 255
    t.string   "phone",            limit: 255
    t.string   "headline",         limit: 255
    t.string   "industry",         limit: 255
    t.string   "urls",             limit: 255
    t.string   "secret",           limit: 255
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website",          limit: 255
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.boolean  "searchable",                     default: false, null: false
    t.string   "public_email",     limit: 255
    t.string   "location",         limit: 255
    t.string   "job_title",        limit: 255
    t.string   "company_name",     limit: 255
    t.string   "company_website",  limit: 255
    t.string   "online_portfolio", limit: 255
    t.string   "linkedin_profile", limit: 255
    t.string   "behance",          limit: 255
    t.string   "vimeo",            limit: 255
    t.text     "social_links",     limit: 65535
    t.text     "skills",           limit: 65535
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "is_company",                     default: false, null: false
    t.boolean  "is_freelancer",                  default: false, null: false
    t.string   "image",            limit: 255
    t.string   "invitation_hash",  limit: 40
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "team_attachments", force: :cascade do |t|
    t.integer  "team_id",         limit: 4
    t.string   "attachment",      limit: 255
    t.string   "attachment_type", limit: 255
    t.string   "description",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_profiles", force: :cascade do |t|
    t.integer  "team_id",           limit: 4
    t.integer  "profile_id",        limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "invitation_status", limit: 25, default: "''"
    t.boolean  "is_admin",                     default: false, null: false
  end

  add_index "team_profiles", ["profile_id"], name: "index_team_profiles_on_profile_id", using: :btree
  add_index "team_profiles", ["team_id", "profile_id"], name: "index_team_profiles_on_team_id_and_profile_id", unique: true, using: :btree
  add_index "team_profiles", ["team_id"], name: "index_team_profiles_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "image",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "owner_id",    limit: 4
    t.boolean  "public",                    default: false, null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "backet",                    default: false, null: false
    t.boolean  "archive",                   default: false, null: false
  end

  add_index "teams", ["archive"], name: "index_teams_on_archive", using: :btree

  create_table "user_preferences", force: :cascade do |t|
    t.integer "user_id", limit: 4,     default: 0, null: false
    t.text    "others",  limit: 65535
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",    null: false
    t.string   "encrypted_password",     limit: 255,   default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "firstname",              limit: 255
    t.string   "lastname",               limit: 255
    t.string   "email2",                 limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "role",                   limit: 4
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",       limit: 4
    t.integer  "invited_by_id",          limit: 4
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",      limit: 4,     default: 0
    t.boolean  "edit_profile",                         default: false, null: false
    t.boolean  "subscribe",                            default: false, null: false
    t.string   "image",                  limit: 255
    t.text     "avatars",                limit: 65535
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "team_profiles", "profiles"
  add_foreign_key "team_profiles", "teams"
end
