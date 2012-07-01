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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120701142830) do

  create_table "contact_people", :force => true do |t|
    t.string   "name"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "handle"
    t.string   "name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoice_templates", :force => true do |t|
    t.string   "paper_size"
    t.text     "header"
    t.string   "address_line"
    t.string   "city"
    t.text     "footer_left"
    t.text     "footer_middle"
    t.text     "footer_right"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
    t.string   "title"
    t.text     "default_comment"
  end

  create_table "invoices", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "invoice_template_id"
    t.date     "date"
    t.string   "number"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_person_id"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "invoice_id"
    t.decimal  "quantity",    :precision => 8, :scale => 2
    t.string   "unit"
    t.text     "description"
    t.decimal  "unit_price",  :precision => 8, :scale => 2
    t.decimal  "vat",         :precision => 4, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.integer  "customer_id"
    t.string   "title"
    t.decimal  "time_budget"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_entries", :force => true do |t|
    t.integer  "project_id"
    t.decimal  "duration"
    t.string   "comment"
    t.date     "date"
    t.boolean  "invoiced",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invoice_id"
  end

end
