WillowDecorators.setup

Interchangeable.define(StudentManagementController, :a_reason_the_new_user_is_invalid) do |c, p|
  lead_id = p[:lead_id] || p[:hive_lead_id]
  return nil unless lead_id.present?
  Refinery::User.where(hive_lead_id: lead_id).any? ?
    'A user exists with this lead id.' : nil
end
