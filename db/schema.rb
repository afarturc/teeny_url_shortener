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

ActiveRecord::Schema[7.1].define(version: 20_240_314_165_518) do
  create_table 'clicks', force: :cascade do |t|
    t.string 'device_ip', null: false
    t.string 'system', null: false
    t.string 'browser', null: false
    t.string 'language', null: false
    t.string 'platform', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'link_id', null: false
  end

  create_table 'links', force: :cascade do |t|
    t.string 'name', default: '', null: false
    t.string 'description', default: '', null: false
    t.string 'original_url', null: false
    t.string 'short_url', null: false
    t.string 'password'
    t.date 'expires_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id', null: false
    t.index ['short_url'], name: 'index_links_on_short_url'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'clicks', 'links'
  add_foreign_key 'links', 'users'
end
