require 'redis-session-store'

# Be sure to restart your server when you modify this file.
if ENV['REDIS_HOST'] && ENV['REDIS_PORT']

  Rails.application.config.session_store :redis_session_store, {
    key: '_student_portal_session',
    redis: {
      expire_after: 60.minutes,
      key_prefix: 'conduit:session:',
      host: ENV['REDIS_HOST'],
      port: ENV['REDIS_PORT']
    }
  }

else

  Rails.application.config.session_store :cookie_store, key: '_student_portal_session'

end
