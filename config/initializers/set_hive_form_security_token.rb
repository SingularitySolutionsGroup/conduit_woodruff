require 'securerandom'

Warden::Manager.after_authentication do |user,auth,opts|
  if user
    user.update_attribute(:hive_form_security_token, SecureRandom.uuid)
  end
end

Warden::Manager.before_logout do |user,auth,opts|
  if user
    user.update_attribute(:hive_form_security_token, nil)
  end
end
