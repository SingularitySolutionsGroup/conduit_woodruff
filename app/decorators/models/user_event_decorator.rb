UserEvent.class_eval do
  class << self
    alias :made_referral :execute_in_the_background

    def made_referral_now user, referral_data
      data = {
               event_type: 'made_referral',
               message:    "#{user.first_name} #{user.last_name} referred \"#{referral_data['first_name']} #{referral_data['last_name']}.\""
             }
      build_event_for user, data, referral_data
    end
      
  end
end
