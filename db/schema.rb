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

ActiveRecord::Schema.define(:version => 20110301212618) do

  create_table "answers", :force => true do |t|
    t.integer  "project_id"
    t.integer  "question_id"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.integer  "target_id"
    t.integer  "level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_num"
  end

  create_table "courses_users", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "know"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_num"
  end

  create_table "finished_exercises", :force => true do |t|
    t.integer  "exercise_id"
    t.integer  "user_id"
    t.boolean  "finished"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", :force => true do |t|
    t.string   "url"
    t.string   "title"
    t.integer  "total_votes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prerequisites", :id => false, :force => true do |t|
    t.integer "course_id",   :default => 0, :null => false
    t.integer "exercise_id", :default => 0, :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", :force => true do |t|
    t.integer  "course_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "targets", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teches", :force => true do |t|
    t.integer  "project_id"
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "image"
    t.boolean  "admin"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
  end

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => false
    t.integer  "voteable_id",                      :null => false
    t.string   "voteable_type",                    :null => false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "index_votes_on_voteable_id_and_voteable_type"
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], :name => "fk_one_vote_per_user_per_entity", :unique => true
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
