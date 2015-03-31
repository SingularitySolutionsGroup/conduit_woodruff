class AddWorkerClassNameToAnonymousFormRequest < ActiveRecord::Migration
  def change
    add_column :anonymous_form_requests, :worker_class_name, :text
  end
end
