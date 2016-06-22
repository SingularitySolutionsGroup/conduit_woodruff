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

ActiveRecord::Schema.define(version: 20160418110300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "analytics", force: true do |t|
    t.datetime "create_date"
    t.integer  "student_application_id"
    t.integer  "user_id"
    t.string   "form_id"
    t.text     "user_agent"
    t.text     "user_action"
    t.integer  "step_id"
    t.text     "status"
  end

  create_table "anonymous_form_requests", force: true do |t|
    t.text     "passthrough_data"
    t.string   "slug"
    t.integer  "form_id"
    t.integer  "form_submission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "worker_class_name"
  end

  create_table "asset_imports", force: true do |t|
    t.string   "created_by"
    t.integer  "created_by_user_id"
    t.string   "modified_by"
    t.integer  "modified_by_user_id"
    t.text     "name"
    t.text     "content"
    t.text     "notes"
    t.text     "meta_data"
    t.boolean  "is_complete"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "available_appointments", force: true do |t|
    t.datetime "from"
    t.datetime "to"
    t.integer  "user_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "group_identifier"
  end

  create_table "binding_fields", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blocked_text_messages", force: true do |t|
    t.string   "to"
    t.string   "from"
    t.text     "message"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "busy_periods", force: true do |t|
    t.datetime "from"
    t.datetime "to"
    t.integer  "user_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "group_identifier"
  end

  create_table "cache_records", force: true do |t|
    t.string   "key"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cached_reports", force: true do |t|
    t.text     "name"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chat_messages", force: true do |t|
    t.text     "message"
    t.integer  "user_id"
    t.integer  "user_application_id"
    t.integer  "master_application_id"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "method"
    t.text     "data"
    t.datetime "sent_at"
    t.text     "sent_data"
    t.string   "sent_status"
  end

  create_table "checklist_approvals", force: true do |t|
    t.integer  "approved_by_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "checklist_key"
    t.integer  "user_id"
  end

  create_table "checklist_item_to_file_relations", force: true do |t|
    t.string   "key"
    t.integer  "user_id"
    t.integer  "user_application_id"
    t.string   "relater_user_id"
    t.string   "related_to_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checklists", force: true do |t|
    t.text     "name"
    t.text     "items"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "related_column_entry"
    t.string   "form"
  end

  create_table "client_side_logs", force: true do |t|
    t.string   "description"
    t.string   "data"
    t.datetime "created_at"
    t.string   "ip_address"
  end

  create_table "collection_items", force: true do |t|
    t.string   "name"
    t.integer  "collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "data"
  end

  create_table "collections", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "tag"
    t.text     "template"
    t.string   "binding_type"
    t.integer  "form_id"
    t.text     "list_view_data"
  end

  create_table "custom_student_checklist_items", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_application_id"
    t.string   "checklist_key"
    t.string   "key"
    t.integer  "creator_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_student_checklist_steps", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_application_id"
    t.string   "checklist_key"
    t.string   "step"
    t.integer  "creator_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_api_requests", force: true do |t|
    t.text     "message_body"
    t.string   "sender_email"
    t.text     "subject"
    t.text     "recipient_emails"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "request_type"
  end

  create_table "file_downloads", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "filepicker_data"
    t.integer  "user_id"
    t.string   "tags"
    t.integer  "user_application_id"
    t.string   "title"
    t.hstore   "step_association_data"
  end

  create_table "file_uploads", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "filepicker_data"
    t.integer  "user_id"
    t.string   "tags"
    t.integer  "user_application_id"
    t.string   "title"
  end

  create_table "form_bindings", force: true do |t|
    t.string "form_id"
    t.string "question_id"
    t.string "control_type"
    t.string "hive_field_name"
    t.string "hive_form_item_name"
  end

  create_table "form_historical_records", force: true do |t|
    t.integer  "form_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "data"
    t.text     "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "new_name"
    t.text     "new_data"
    t.text     "new_tags"
  end

  create_table "form_migration_logs", force: true do |t|
    t.integer  "form_id"
    t.text     "name"
    t.text     "tags"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "form_submission_logs", force: true do |t|
    t.text     "params"
    t.string   "form_id"
    t.integer  "step_id"
    t.integer  "user_id"
    t.integer  "student_application_state_id"
    t.string   "hive_lead_id"
    t.boolean  "successful"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "analytic_id"
  end

  create_table "form_submissions", force: true do |t|
    t.text     "form_name"
    t.integer  "form_id"
    t.integer  "user_id"
    t.integer  "user_application_id"
    t.text     "form"
    t.text     "input"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "replace_tags"
    t.text     "replace_tag_data"
    t.string   "ip_address"
    t.integer  "step_id"
  end

  create_table "forms", force: true do |t|
    t.string   "name"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "tags"
  end

  create_table "google_appointment_logs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "available_appointment"
    t.text     "event"
    t.string   "google_calendar_id"
    t.integer  "user_id"
    t.integer  "user_application_id"
    t.text     "result"
  end

  create_table "google_authentications", force: true do |t|
    t.integer  "user_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hive_records", force: true do |t|
    t.string   "lead_id"
    t.hstore   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "agent_name"
    t.datetime "create_date"
    t.datetime "last_activity_at"
    t.string   "status_title"
  end

  add_index "hive_records", ["data"], name: "index_hive_records_on_data", using: :gist
  add_index "hive_records", ["email"], name: "index_hive_records_on_email", using: :btree
  add_index "hive_records", ["first_name"], name: "index_hive_records_on_first_name", using: :btree
  add_index "hive_records", ["last_activity_at"], name: "index_hive_records_on_last_activity_at", using: :btree
  add_index "hive_records", ["last_name"], name: "index_hive_records_on_last_name", using: :btree
  add_index "hive_records", ["lead_id"], name: "index_hive_records_on_lead_id", using: :btree

  create_table "important_field_updates", force: true do |t|
    t.string   "field"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "old_value"
    t.string   "new_value"
    t.datetime "changed_at"
    t.integer  "lead_data_change_log_id"
    t.string   "lead_id"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "incrementing_integers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "integration_requests", force: true do |t|
    t.string   "method"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lead_data_change_logs", force: true do |t|
    t.text     "changed_keys"
    t.text     "changed_new_data"
    t.text     "changed_original_data"
    t.string   "lead_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lead_data_stamps", force: true do |t|
    t.integer  "user_application_id"
    t.integer  "user_id"
    t.text     "data"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lead_entries", force: true do |t|
    t.text     "input"
    t.text     "form"
    t.text     "request"
    t.integer  "user_id"
    t.string   "lead_id"
    t.string   "match"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "details"
  end

  create_table "login_records", force: true do |t|
    t.string   "ip"
    t.integer  "user_id"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "login_tokens", force: true do |t|
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "redeemed"
    t.datetime "redeemed_at"
    t.datetime "expires_at"
    t.integer  "by_user_id"
    t.datetime "sent_at"
    t.text     "sent_data"
  end

  create_table "mandrill_sent_emails", force: true do |t|
    t.text     "request"
    t.text     "response"
    t.boolean  "successful"
    t.string   "template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mandrill_webhook_messages", force: true do |t|
    t.integer  "integration_request_id"
    t.text     "data"
    t.text     "user_event_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "master_application_historical_records", force: true do |t|
    t.string   "old_name"
    t.string   "new_name"
    t.text     "old_application_stamp"
    t.text     "new_application_stamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "master_application_id"
  end

  create_table "master_applications", force: true do |t|
    t.string   "name"
    t.text     "application_stamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "master_data", force: true do |t|
    t.string   "key"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_response_needs", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "missing_secondary_signatures", force: true do |t|
    t.integer  "primary_user_application_id"
    t.integer  "primary_user_id"
    t.integer  "primary_form_submission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "component_id"
    t.string   "slug"
    t.string   "security_token"
    t.integer  "order"
  end

  create_table "not_applicable_reviews", force: true do |t|
    t.integer  "user_id"
    t.string   "key"
    t.integer  "reviewer_user_id"
    t.string   "checklist_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "removed_by_user_id"
    t.datetime "removed_at"
  end

  create_table "notes", force: true do |t|
    t.text     "note"
    t.string   "user_id"
    t.string   "username"
    t.datetime "created_at"
    t.string   "hive_client_id"
    t.string   "hive_lead_id"
    t.integer  "refinery_user_id"
  end

  create_table "original_form_definition_logs", force: true do |t|
    t.text     "data"
    t.integer  "form_id"
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "form_submission_id"
    t.boolean  "matches_the_form_submission"
  end

  create_table "packages", force: true do |t|
    t.integer  "user_id"
    t.text     "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "requested_by_user_id"
    t.integer  "user_application_id"
    t.text     "result"
    t.string   "status"
    t.string   "name"
    t.string   "definition_id"
    t.string   "package_type"
  end

  create_table "potential_secondary_signature_signers", force: true do |t|
    t.string   "email"
    t.integer  "missing_secondary_signature_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "notified_at"
  end

  create_table "refinery_images", force: true do |t|
    t.string   "image_mime_type"
    t.string   "image_name"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_uid"
    t.string   "image_ext"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_page_parts", force: true do |t|
    t.integer  "refinery_page_id"
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refinery_page_parts", ["id"], name: "index_refinery_page_parts_on_id", using: :btree
  add_index "refinery_page_parts", ["refinery_page_id"], name: "index_refinery_page_parts_on_refinery_page_id", using: :btree

  create_table "refinery_pages", force: true do |t|
    t.integer  "parent_id"
    t.string   "path"
    t.string   "slug"
    t.boolean  "show_in_menu",        default: true
    t.string   "link_url"
    t.string   "menu_match"
    t.boolean  "deletable",           default: true
    t.boolean  "draft",               default: false
    t.boolean  "skip_to_first_child", default: false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "view_template"
    t.string   "layout_template"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refinery_pages", ["depth"], name: "index_refinery_pages_on_depth", using: :btree
  add_index "refinery_pages", ["id"], name: "index_refinery_pages_on_id", using: :btree
  add_index "refinery_pages", ["lft"], name: "index_refinery_pages_on_lft", using: :btree
  add_index "refinery_pages", ["parent_id"], name: "index_refinery_pages_on_parent_id", using: :btree
  add_index "refinery_pages", ["rgt"], name: "index_refinery_pages_on_rgt", using: :btree

  create_table "refinery_resources", force: true do |t|
    t.string   "file_mime_type"
    t.string   "file_name"
    t.integer  "file_size"
    t.string   "file_uid"
    t.string   "file_ext"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_roles", force: true do |t|
    t.string "title"
  end

  create_table "refinery_roles_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "refinery_roles_users", ["role_id", "user_id"], name: "index_refinery_roles_users_on_role_id_and_user_id", using: :btree
  add_index "refinery_roles_users", ["user_id", "role_id"], name: "index_refinery_roles_users_on_user_id_and_role_id", using: :btree

  create_table "refinery_user_plugins", force: true do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "position"
  end

  add_index "refinery_user_plugins", ["name"], name: "index_refinery_user_plugins_on_name", using: :btree
  add_index "refinery_user_plugins", ["user_id", "name"], name: "index_refinery_user_plugins_on_user_id_and_name", unique: true, using: :btree

  create_table "refinery_users", force: true do |t|
    t.string   "username",                         null: false
    t.string   "email",                            null: false
    t.string   "encrypted_password",               null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count"
    t.datetime "remember_created_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "hive_client_id"
    t.string   "hive_lead_id"
    t.string   "external_id"
    t.string   "account_activation_id"
    t.boolean  "is_account_activated"
    t.datetime "account_activation_id_stamp_date"
    t.string   "assigned_agent_email"
    t.string   "assigned_agent_id"
    t.string   "assigned_agent_name"
    t.string   "assigned_agent_group_id"
    t.string   "assigned_agent_group_name"
    t.string   "forgot_password_id"
    t.datetime "forgot_password_date"
    t.boolean  "force_password_reset"
    t.string   "hive_form_security_token"
    t.text     "application_stamp"
    t.text     "notification_bcc"
    t.text     "activation_token1"
    t.text     "activation_token2"
    t.text     "activation_token3"
    t.datetime "activation_token_create_date"
    t.integer  "master_application_id"
    t.text     "important_data"
    t.datetime "last_activity_at"
    t.string   "last_user_agent"
    t.string   "last_browser_name"
    t.text     "avatar_url"
    t.string   "phone"
  end

  add_index "refinery_users", ["hive_lead_id"], name: "index_refinery_users_on_hive_lead_id", using: :btree
  add_index "refinery_users", ["id"], name: "index_refinery_users_on_id", using: :btree
  add_index "refinery_users", ["username"], name: "refinery_users_unique_username", unique: true, using: :btree

  create_table "reviews", force: true do |t|
    t.string   "key"
    t.integer  "user_id"
    t.integer  "user_application_id"
    t.integer  "reviewer_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scheduled_reports", force: true do |t|
    t.string   "to"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notification"
    t.string   "name"
    t.string   "report_id"
    t.datetime "next_recurrence"
    t.string   "tickle_expression"
    t.datetime "last_sent_at"
    t.string   "filter"
    t.string   "send_empty_reports"
  end

  create_table "schools", force: true do |t|
    t.text     "name"
    t.text     "ipeds_id"
    t.text     "street"
    t.text     "street2"
    t.text     "city"
    t.text     "state"
    t.text     "zip"
    t.text     "school_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seam_efforts", force: true do |t|
    t.string   "effort_id"
    t.string   "next_step"
    t.datetime "next_execute_at"
    t.boolean  "complete"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "secondary_signatures", force: true do |t|
    t.text     "form_name"
    t.integer  "form_id"
    t.integer  "user_id"
    t.integer  "user_application_id"
    t.text     "form"
    t.text     "input"
    t.text     "replace_tags"
    t.text     "replace_tag_data"
    t.string   "ip_address"
    t.integer  "step_id"
    t.integer  "primary_user_application_id"
    t.integer  "primary_user_id"
    t.integer  "primary_form_submission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "missing_secondary_signature_id"
  end

  create_table "sent_text_messages", force: true do |t|
    t.string   "to"
    t.string   "from"
    t.text     "message"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seo_meta", force: true do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type"
    t.string   "browser_title"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seo_meta", ["id"], name: "index_seo_meta_on_id", using: :btree
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], name: "index_seo_meta_on_seo_meta_id_and_seo_meta_type", using: :btree

  create_table "sidekiq_job_backups", force: true do |t|
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_configurations", force: true do |t|
    t.string "name"
    t.string "value"
  end

  create_table "sms_blacklists", force: true do |t|
    t.integer  "user_id"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "soft_student_application_state_deletions", force: true do |t|
    t.integer  "student_application_state_id"
    t.integer  "by_userid"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "soft_user_deletions", force: true do |t|
    t.integer  "user_id"
    t.integer  "by_user_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "step_groups", force: true do |t|
    t.string  "name"
    t.integer "sequence"
  end

  create_table "step_resources", force: true do |t|
    t.integer  "master_application_id"
    t.integer  "step_id"
    t.text     "filepicker_data"
    t.text     "notes"
    t.text     "content"
    t.boolean  "completed"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "steps", force: true do |t|
    t.integer "step_group_id"
    t.string  "name"
    t.string  "form_id"
    t.boolean "is_skippable"
    t.string  "button_text"
    t.string  "type"
    t.string  "error_text"
    t.string  "tag"
    t.boolean "should_send_notifications"
    t.string  "details"
    t.integer "sequence"
    t.boolean "default_step"
    t.text    "hooks"
    t.string  "uuid"
  end

  create_table "student_application_states", force: true do |t|
    t.integer  "student_application_id"
    t.integer  "user_id"
    t.string   "form_id"
    t.string   "status"
    t.string   "external_id"
    t.integer  "step_id"
    t.string   "submission_id"
    t.string   "pdf_filename"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "step_name"
    t.text     "step_details"
    t.text     "data"
    t.integer  "user_application_id"
  end

  add_index "student_application_states", ["step_id"], name: "index_student_application_states_on_step_id", using: :btree
  add_index "student_application_states", ["submission_id"], name: "index_student_application_states_on_submission_id", using: :btree
  add_index "student_application_states", ["user_application_id"], name: "index_student_application_states_on_user_application_id", using: :btree
  add_index "student_application_states", ["user_id", "step_id"], name: "index_student_application_states_on_user_id_and_step_id", using: :btree
  add_index "student_application_states", ["user_id", "user_application_id"], name: "user_id_and_app_id", using: :btree
  add_index "student_application_states", ["user_id"], name: "index_student_application_states_on_user_id", using: :btree

  create_table "student_checklist_item_deletions", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_application_id"
    t.integer  "checklist_key"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temporary_data_stores", force: true do |t|
    t.string   "key"
    t.datetime "expire_at"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracked_events", force: true do |t|
    t.string   "lead_id"
    t.string   "event_name"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "unsubscribe_requests", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_application_event_logs", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_application_id"
    t.integer  "user_id_of_modifier"
    t.string   "username_of_modifier"
    t.text     "pre_update_application_stamp"
    t.text     "post_update_application_stamp"
    t.hstore   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_type"
  end

  create_table "user_application_histories", force: true do |t|
    t.integer  "user_application_id"
    t.integer  "master_application_id"
    t.integer  "user_id"
    t.text     "application_stamp"
    t.hstore   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_applications", force: true do |t|
    t.integer  "master_application_id"
    t.integer  "user_id"
    t.text     "application_stamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "data"
    t.boolean  "uses_default_application"
  end

  add_index "user_applications", ["data"], name: "index_user_applications_on_data", using: :gist

  create_table "user_assets", force: true do |t|
    t.integer  "user_id"
    t.text     "filepicker_data"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "public_url"
  end

  create_table "user_events", force: true do |t|
    t.integer  "user_id"
    t.string   "event_type"
    t.string   "message"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_application_id"
  end

  add_index "user_events", ["event_type"], name: "index_user_events_on_event_type", using: :btree
  add_index "user_events", ["user_id", "event_type"], name: "index_user_events_on_user_id_and_event_type", using: :btree
  add_index "user_events", ["user_id"], name: "index_user_events_on_user_id", using: :btree

  create_table "user_master_application_id_change_logs", force: true do |t|
    t.integer  "user_id"
    t.integer  "from_master_application_id"
    t.integer  "to_master_application_id"
    t.integer  "admin_user_id"
    t.string   "admin_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_notifications", force: true do |t|
    t.integer  "user_id"
    t.integer  "user_event_id"
    t.integer  "related_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "message"
  end

  add_index "user_notifications", ["created_at"], name: "index_user_notifications_on_created_at", using: :btree
  add_index "user_notifications", ["created_at"], name: "user_notifications_created_at_in_desc", order: {"created_at"=>:desc}, using: :btree
  add_index "user_notifications", ["user_id"], name: "index_user_notifications_on_user_id", using: :btree

  create_table "user_tags", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_tags_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "user_tag_id"
  end

  create_table "velocify_integration_logs", force: true do |t|
    t.string   "method"
    t.text     "data"
    t.string   "lead_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "verification_emails", force: true do |t|
    t.integer  "user_id"
    t.string   "url"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
    t.boolean  "verified"
    t.datetime "verified_at"
  end

  create_table "walk_ins", force: true do |t|
    t.text     "input"
    t.text     "form"
    t.text     "request"
    t.integer  "user_id"
    t.string   "lead_id"
    t.string   "match"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "details"
  end

  create_table "web_requests", force: true do |t|
    t.string   "controller"
    t.string   "action"
    t.integer  "user_id"
    t.text     "request"
    t.text     "params"
    t.string   "ip_address"
    t.text     "user_agent"
    t.text     "referer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "completed_at"
    t.integer  "completed_in"
  end

end
