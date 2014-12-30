require 'devise'
ActiveSupport.on_load(:active_record) do
  Devise.setup do
    require 'devise/orm/active_record'
  end
end
Devise.setup do |config|
  #config.secret_key = ENV['DEVISE_SECRET_KEY'] || SecureRandom.hex
  config.case_insensitive_keys = [:email, :username]
  config.authentication_keys = [ :login ]
  config.password_length = 4..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end

Refinery::User.class_eval do
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :authentication_keys => [:login]
end