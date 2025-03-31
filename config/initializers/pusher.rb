#Starting Poxa using app_key: <<"b">>, app_id: <<"a">>, app_secret: <<"c">> on port 3003

#POXA_HOST
#POXA_PORT
#POXA_APP_ID
#POXA_APP_KEY
#POXA_APP_SECRET

PoxaAssist.start

module PoxaSecurity
  def self.auth controller, params

    user = controller.send(:current_refinery_user)
    return nil unless user

    #if params[:channel_name].starts_with? "chat-"
      #return nil if params[:channel_name].gsub('chat-', '') != user.hive_lead_id
    #end

    {
      :user_id => user.id,
      :user_info => {
                      #email: user.email,
                      #lead_id: user.hive_lead_id
                    }
    }
  end
end

PoxaAssist.instance_eval do
  def self.auth options
    PoxaSecurity.auth options[:controller], options[:params]
  end
end
