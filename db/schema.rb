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

ActiveRecord::Schema.define(:version => 20141030212214) do

  create_table "analytics", :force => true do |t|
    t.datetime "create_date"
    t.integer  "student_application_id"
    t.integer  "user_id"
    t.string   "form_id"
    t.text     "user_agent"
    t.text     "user_action"
    t.integer  "step_id"
    t.text     "status"
  end

  create_table "asset_imports", :force => true do |t|
    t.string   "created_by"
    t.integer  "created_by_user_id"
    t.string   "modified_by"
    t.integer  "modified_by_user_id"
    t.text     "name"
    t.text     "content"
    t.text     "notes"
    t.text     "meta_data"
    t.boolean  "is_complete"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "binding_fields", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "blocked_text_messages", :force => true do |t|
    t.string   "to"
    t.string   "from"
    t.text     "message"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cached_reports", :force => true do |t|
    t.text     "name"
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "chat_messages", :force => true do |t|
    t.text     "message"
    t.integer  "user_id"
    t.integer  "user_application_id"
    t.integer  "master_application_id"
    t.string   "source"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "name"
    t.string   "method"
    t.text     "data"
  end

  create_table "client_side_logs", :force => true do |t|
    t.string   "description"
    t.string   "data"
    t.datetime "created_at"
    t.string   "ip_address"
  end

  create_table "collection_items", :force => true do |t|
    t.string   "name"
    t.integer  "collection_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.hstore   "data"
  end

  create_table "collections", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "tag"
    t.text     "template"
  end

  create_table "file_downloads", :force => true do |t|
    t.text     "name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "filepicker_data"
    t.integer  "user_id"
    t.string   "tags"
    t.integer  "user_application_id"
  end

  create_table "file_uploads", :force => true do |t|
    t.text     "name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "filepicker_data"
    t.integer  "user_id"
    t.string   "tags"
    t.integer  "user_application_id"
  end

  create_table "form_bindings", :force => true do |t|
    t.string "form_id"
    t.string "question_id"
    t.string "control_type"
    t.string "hive_field_name"
    t.string "hive_form_item_name"
  end

  create_table "form_historical_records", :force => true do |t|
    t.integer  "form_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "data"
    t.text     "tags"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "new_name"
    t.text     "new_data"
    t.text     "new_tags"
  end

  create_table "form_migration_logs", :force => true do |t|
    t.integer  "form_id"
    t.text     "name"
    t.text     "tags"
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "form_submission_logs", :force => true do |t|
    t.text     "params"
    t.string   "form_id"
    t.integer  "step_id"
    t.integer  "user_id"
    t.integer  "student_application_state_id"
    t.string   "hive_lead_id"
    t.boolean  "successful"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "analytic_id"
  end

  create_table "form_submissions", :force => true do |t|
    t.text     "form_name"
    t.integer  "form_id"
    t.integer  "user_id"
    t.integer  "user_application_id"
    t.text     "form"
    t.text     "input"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "replace_tags"
    t.text     "replace_tag_data"
    t.string   "ip_address"
    t.integer  "step_id"
  end

  create_table "forms", :force => true do |t|
    t.string   "name"
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "tags"
  end

  create_table "hive_records", :force => true do |t|
    t.string   "lead_id"
    t.hstore   "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "agent_name"
  end

  add_index "hive_records", ["data"], :name => "index_hive_records_on_data"

  create_table "integration_requests", :force => true do |t|
    t.string   "method"
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "login_records", :force => true do |t|
    t.string   "ip"
    t.integer  "user_id"
    t.string   "username"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "master_applications", :force => true do |t|
    t.string   "name"
    t.text     "application_stamp"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "master_data", :force => true do |t|
    t.string   "key"
    t.text     "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "message_response_needs", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "missing_secondary_signatures", :force => true do |t|
    t.integer  "primary_user_application_id"
    t.integer  "primary_user_id"
    t.integer  "primary_form_submission_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "component_id"
    t.string   "slug"
    t.string   "security_token"
  end

  create_table "notes", :force => true do |t|
    t.text     "note"
    t.string   "user_id"
    t.string   "username"
    t.datetime "created_at"
    t.string   "hive_client_id"
    t.string   "hive_lead_id"
    t.integer  "refinery_user_id"
  end

  create_table "original_form_definition_logs", :force => true do |t|
    t.text     "data"
    t.integer  "form_id"
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "form_submission_id"
    t.boolean  "matches_the_form_submission"
  end

  create_table "packages", :force => true do |t|
    t.integer  "user_id"
    t.text     "definition"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "requested_by_user_id"
    t.integer  "user_application_id"
    t.text     "result"
    t.string   "status"
    t.string   "name"
    t.string   "definition_id"
    t.string   "package_type"
  end

  create_table "potential_secondary_signature_signers", :force => true do |t|
    t.string   "email"
    t.integer  "missing_secondary_signature_id"
    t.string   "slug"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.datetime "notified_at"
  end

  create_table "refinery_images", :force => true do |t|
    t.string   "image_mime_type"
    t.string   "image_name"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_uid"
    t.string   "image_ext"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "refinery_page_part_translations", :force => true do |t|
    t.integer  "refinery_page_part_id"
    t.string   "locale"
    t.text     "body"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "refinery_page_part_translations", ["locale"], :name => "index_refinery_page_part_translations_on_locale"
  add_index "refinery_page_part_translations", ["refinery_page_part_id"], :name => "index_refinery_page_part_translations_on_refinery_page_part_id"

  create_table "refinery_page_parts", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_parts", ["id"], :name => "index_refinery_page_parts_on_id"
  add_index "refinery_page_parts", ["refinery_page_id"], :name => "index_refinery_page_parts_on_refinery_page_id"

  create_table "refinery_page_translations", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "locale"
    t.string   "title"
    t.string   "custom_slug"
    t.string   "menu_title"
    t.string   "slug"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_translations", ["locale"], :name => "index_refinery_page_translations_on_locale"
  add_index "refinery_page_translations", ["refinery_page_id"], :name => "index_refinery_page_translations_on_refinery_page_id"

  create_table "refinery_pages", :force => true do |t|
    t.integer  "parent_id"
    t.string   "path"
    t.string   "slug"
    t.boolean  "show_in_menu",        :default => true
    t.string   "link_url"
    t.string   "menu_match"
    t.boolean  "deletable",           :default => true
    t.boolean  "draft",               :default => false
    t.boolean  "skip_to_first_child", :default => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "view_template"
    t.string   "layout_template"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "refinery_pages", ["depth"], :name => "index_refinery_pages_on_depth"
  add_index "refinery_pages", ["id"], :name => "index_refinery_pages_on_id"
  add_index "refinery_pages", ["lft"], :name => "index_refinery_pages_on_lft"
  add_index "refinery_pages", ["parent_id"], :name => "index_refinery_pages_on_parent_id"
  add_index "refinery_pages", ["rgt"], :name => "index_refinery_pages_on_rgt"

  create_table "refinery_resources", :force => true do |t|
    t.string   "file_mime_type"
    t.string   "file_name"
    t.integer  "file_size"
    t.string   "file_uid"
    t.string   "file_ext"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "refinery_roles", :force => true do |t|
    t.string "title"
  end

  create_table "refinery_roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "refinery_roles_users", ["role_id", "user_id"], :name => "index_refinery_roles_users_on_role_id_and_user_id"
  add_index "refinery_roles_users", ["user_id", "role_id"], :name => "index_refinery_roles_users_on_user_id_and_role_id"

  create_table "refinery_user_plugins", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "position"
  end

  add_index "refinery_user_plugins", ["name"], :name => "index_refinery_user_plugins_on_name"
  add_index "refinery_user_plugins", ["user_id", "name"], :name => "index_refinery_user_plugins_on_user_id_and_name", :unique => true

  create_table "refinery_users", :force => true do |t|
    t.string   "username",                         :null => false
    t.string   "email",                            :null => false
    t.string   "encrypted_password",               :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count"
    t.datetime "remember_created_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
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
  end

  add_index "refinery_users", ["id"], :name => "index_refinery_users_on_id"

  create_table "schools", :force => true do |t|
    t.text     "name"
    t.text     "ipeds_id"
    t.text     "street"
    t.text     "street2"
    t.text     "city"
    t.text     "state"
    t.text     "zip"
    t.text     "school_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "seam_efforts", :force => true do |t|
    t.string   "effort_id"
    t.string   "next_step"
    t.datetime "next_execute_at"
    t.boolean  "complete"
    t.text     "data"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "secondary_signatures", :force => true do |t|
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
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "missing_secondary_signature_id"
  end

  create_table "sent_text_messages", :force => true do |t|
    t.string   "to"
    t.string   "from"
    t.text     "message"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "seo_meta", :force => true do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type"
    t.string   "browser_title"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "seo_meta", ["id"], :name => "index_seo_meta_on_id"
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], :name => "index_seo_meta_on_seo_meta_id_and_seo_meta_type"

  create_table "site_configurations", :force => true do |t|
    t.string "name"
    t.string "value"
  end

  create_table "sms_blacklists", :force => true do |t|
    t.integer  "user_id"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "soft_user_deletions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "by_user_id"
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "step_groups", :force => true do |t|
    t.string  "name"
    t.integer "sequence"
  end

  create_table "steps", :force => true do |t|
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
  end

  create_table "student_application_states", :force => true do |t|
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

  create_table "tracked_events", :force => true do |t|
    t.string   "lead_id"
    t.string   "event_name"
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "unsubscribe_requests", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_application_event_logs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_application_id"
    t.integer  "user_id_of_modifier"
    t.string   "username_of_modifier"
    t.text     "pre_update_application_stamp"
    t.text     "post_update_application_stamp"
    t.hstore   "data"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "event_type"
  end

  create_table "user_application_histories", :force => true do |t|
    t.integer  "user_application_id"
    t.integer  "master_application_id"
    t.integer  "user_id"
    t.text     "application_stamp"
    t.hstore   "data"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "user_applications", :force => true do |t|
    t.integer  "master_application_id"
    t.integer  "user_id"
    t.text     "application_stamp"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.hstore   "data"
  end

  add_index "user_applications", ["data"], :name => "index_user_applications_on_data"

  create_table "user_events", :force => true do |t|
    t.integer  "user_id"
    t.string   "event_type"
    t.string   "message"
    t.text     "data"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "user_application_id"
  end

  create_table "user_notifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_event_id"
    t.integer  "related_user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "message"
  end

  create_table "user_tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_tags_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "user_tag_id"
  end

  create_table "web_requests", :force => true do |t|
    t.string   "controller"
    t.string   "action"
    t.integer  "user_id"
    t.text     "request"
    t.text     "params"
    t.string   "ip_address"
    t.text     "user_agent"
    t.text     "referer"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.time     "completed_at"
    t.integer  "completed_in"
  end

end
