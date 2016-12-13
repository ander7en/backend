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

ActiveRecord::Schema.define(version: 20161213054854) do

  create_table "driver_channels", force: :cascade do |t|
    t.string  "channel_id"
    t.integer "driver_id"
    t.index ["driver_id"], name: "index_driver_channels_on_driver_id"
  end

  create_table "driver_query", force: :cascade do |t|
    t.string   "user_channel_id"
    t.integer  "driver_id"
    t.integer  "order_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "carInfo"
    t.float    "pricePerKm"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "status",     default: 1
    t.string   "password"
    t.string   "email"
  end

  create_table "orders", force: :cascade do |t|
    t.float   "source_longitude"
    t.float   "source_latitude"
    t.float   "dest_longitude"
    t.float   "dest_latitude"
    t.integer "status"
    t.integer "driver_id"
    t.integer "price"
    t.index ["driver_id"], name: "index_orders_on_driver_id"
  end

end
