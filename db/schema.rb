# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_230_819_210_725) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'
  enable_extension 'postgis'
  enable_extension 'timescaledb'

  create_table 'ahoy_events', force: :cascade do |t|
    t.bigint 'visit_id'
    t.bigint 'user_id'
    t.string 'name'
    t.jsonb 'properties'
    t.datetime 'time'
    t.index %w[name time], name: 'index_ahoy_events_on_name_and_time'
    t.index ['properties'], name: 'index_ahoy_events_on_properties', opclass: :jsonb_path_ops, using: :gin
    t.index ['user_id'], name: 'index_ahoy_events_on_user_id'
    t.index ['visit_id'], name: 'index_ahoy_events_on_visit_id'
  end

  create_table 'ahoy_visits', force: :cascade do |t|
    t.string 'visit_token'
    t.string 'visitor_token'
    t.bigint 'user_id'
    t.string 'ip'
    t.text 'user_agent'
    t.text 'referrer'
    t.string 'referring_domain'
    t.text 'landing_page'
    t.string 'browser'
    t.string 'os'
    t.string 'device_type'
    t.string 'country'
    t.string 'region'
    t.string 'city'
    t.float 'latitude'
    t.float 'longitude'
    t.string 'utm_source'
    t.string 'utm_medium'
    t.string 'utm_term'
    t.string 'utm_content'
    t.string 'utm_campaign'
    t.string 'app_version'
    t.string 'os_version'
    t.string 'platform'
    t.datetime 'started_at'
    t.index ['user_id'], name: 'index_ahoy_visits_on_user_id'
    t.index ['visit_token'], name: 'index_ahoy_visits_on_visit_token', unique: true
  end

  create_table 'notable_jobs', force: :cascade do |t|
    t.string 'note_type'
    t.text 'note'
    t.text 'job'
    t.string 'job_id'
    t.string 'queue'
    t.float 'runtime'
    t.float 'queued_time'
    t.datetime 'created_at'
  end

  create_table 'notable_requests', force: :cascade do |t|
    t.string 'note_type'
    t.text 'note'
    t.string 'user_type'
    t.bigint 'user_id'
    t.text 'action'
    t.integer 'status'
    t.text 'url'
    t.string 'request_id'
    t.string 'ip'
    t.text 'user_agent'
    t.text 'referrer'
    t.text 'params'
    t.float 'request_time'
    t.datetime 'created_at'
    t.index %w[user_type user_id], name: 'index_notable_requests_on_user'
  end

  create_table 'spatial_ref_sys', primary_key: 'srid', id: :integer, default: nil, force: :cascade do |t|
    t.string 'auth_name', limit: 256
    t.integer 'auth_srid'
    t.string 'srtext', limit: 2048
    t.string 'proj4text', limit: 2048
    t.check_constraint 'srid > 0 AND srid <= 998999', name: 'spatial_ref_sys_srid_check'
  end
end
