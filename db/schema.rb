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

ActiveRecord::Schema.define(version: 20130707215221) do

  create_table "senadores", force: true do |t|
    t.string   "nome"
    t.date     "nascimento"
    t.string   "partido"
    t.string   "uf"
    t.string   "naturalidade"
    t.string   "endereco"
    t.string   "telefone"
    t.string   "fax"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "id_original"
    t.string   "alcunha"
  end

  add_index "senadores", ["nome"], name: "index_senadores_on_nome", unique: true

end
