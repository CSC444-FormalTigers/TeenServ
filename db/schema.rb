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

ActiveRecord::Schema.define(version: 20171130154610) do

  create_table "changelogs", force: :cascade do |t|
    t.datetime "timestamp"
    t.text "change"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "endorsements", force: :cascade do |t|
    t.string "endorser"
    t.string "endorsee"
    t.string "skill"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_applications", force: :cascade do |t|
    t.string "applicant_username"
    t.integer "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "is_accepted", default: false
    t.index ["job_id"], name: "index_job_applications_on_job_id"
    t.index ["user_id"], name: "index_job_applications_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "username"
    t.string "title"
    t.text "description"
    t.boolean "reocurring"
    t.datetime "work_date"
    t.datetime "response_deadline"
    t.integer "hourly_pay"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "is_accepting_applicants", default: true
    t.string "payment_method"
    t.string "location"
    t.string "type_of_service"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "reviewer"
    t.string "reviewee"
    t.integer "service_id"
    t.integer "rating"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "username"
    t.string "skill"
    t.integer "proficiency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teenagers", force: :cascade do |t|
    t.text "username"
    t.integer "rating"
    t.decimal "account_balance"
    t.text "bank_key"
    t.text "description"
    t.text "resume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string "from_user"
    t.string "to_user"
    t.integer "service_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.text "gender"
    t.text "cell_phone"
    t.text "home_phone"
    t.text "name"
    t.text "address"
    t.text "photo"
    t.text "account_type"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.boolean "admin", default: false
    t.string "avatar"
    t.string "resume"
    t.integer "rating", default: 0
    t.string "paypal_email"
    t.boolean "banned"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
