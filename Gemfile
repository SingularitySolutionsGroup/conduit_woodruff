source 'https://rubygems.org'

module WillowDependencies

  def self.load_my_dependencies gemfile
    gemfile.gem 'rails', '4.1.7'
    gemfile.gem 'uuid'
    gemfile.gem 'subtle'
    gemfile.gem 'chronic'
    gemfile.gem 'mongoid'
    gemfile.gem 'savon', '~> 1.2.0'
    gemfile.gem 'foreman'
    gemfile.gem 'yell'
    gemfile.gem "sentry-raven", :git => "https://github.com/getsentry/raven-ruby.git"
    gemfile.gem 'poxa_assist', git: 'git@github.com:PinnacleVenture/poxa_assist.git'
    #gemfile.gem 'activerecord-postgres-hstore'
    gemfile.gem 'activerecord-postgres-hstore', git: 'https://github.com/darrencauthon/activerecord-postgres-hstore.git'
    gemfile.gem 'seam'
    gemfile.gem 'seam-active_record'
    gemfile.gem 'seam-sidekiq'
    gemfile.gem 'interchangeable'
    gemfile.gem 'stripe'
    gemfile.gem 'three'
    gemfile.gem 'pdf-reader'
    gemfile.gem 'filepicker-rails', '1.4.0'
    gemfile.gem 'twilio-ruby'
    gemfile.gem 'whenever'
    gemfile.gem 'pdfcrowd'
    gemfile.gem 'bunny', '0.9.0.pre13'
    gemfile.gem 'daemons'
    gemfile.gem 'eventmachine'
    gemfile.gem 'aws-sdk'
    gemfile.gem 'httparty'
    gemfile.gem 'mechanize'
    gemfile.gem 'will_paginate', '~> 3.0'
    gemfile.gem 'mandrill-api'
    gemfile.gem 'htmlentities'
    gemfile.gem 'mixpanel-ruby'
    gemfile.gem 'sidekiq', '2.16.0'
    gemfile.gem 'sidekiq-failures'
    gemfile.gem 'sidetiq', '0.6.1'
    gemfile.gem 'rubyXL'
    gemfile.gem 'zip'
    gemfile.gem 'venn'
    gemfile.gem 'mixpanel_client'
    gemfile.gem 'slim', '>= 1.1.0'
    gemfile.gem 'sinatra', '>= 1.3.0', :require => nil
    gemfile.gem 'ekg'
    gemfile.gem 'rack-rewrite'
    gemfile.gem 'rack-plastic'
    gemfile.gem 'panic_board_data'
    gemfile.gem 'valid_email2'
    gemfile.gem 'mobile-fu', git: 'https://github.com/PinnacleVenture/mobile-fu.git'
    gemfile.gem 'unicorn'
    gemfile.gem 'pg'
    gemfile.gem 'haml', '~> 4.0.0'
    gemfile.gem 'jquery-rails', '~> 2.0.0'
    gemfile.gem 'the_google', git: 'https://github.com/darrencauthon/the_google.git'
    gemfile.gem 'browser'

    gemfile.gem 'devise', '>= 3.0.0'
    gemfile.gem 'babosa', '0.3.11'
    gemfile.gem 'bcrypt', '3.1.7'
    gemfile.gem 'bcrypt-ruby', '3.1.5'
    gemfile.gem 'friendly_id', '>= 4.0.9'
    #gemfile.gem 'globalize3', '0.3.1'
    gemfile.gem 'orm_adapter'#, '0.0.7'
    #gemfile.gem 'paper_trail', '2.7.2'
    gemfile.gem 'dragonfly', '0.9.15'
    gemfile.gem 'routing-filter', '0.3.1'
    gemfile.gem 'seo_meta', '1.3.0'
    gemfile.gem 'truncate_html', '0.5.5'
    gemfile.gem 'warden'#, '1.1.1'

    gemfile.gem 'velocify', git: 'git@github.com:SingularitySolutionsGroup/velocify.git'

    gemfile.gem 'tickle', git: 'https://github.com/darrencauthon/tickle.git'

    gemfile.gem 'source_code'

    gemfile.gem 'ajax-datatables-rails', git: 'https://github.com/darrencauthon/ajax-datatables-rails.git'

    gemfile.gem 'gersion'

    gemfile.group :development, :test do
      #gemfile.gem 'sqlite3' unless ENV['HOME'] == '/home/ubuntu'
      gemfile.gem 'minitest'
      gemfile.gem 'minitest-rails'
      gemfile.gem 'minitest-reporters'
      gemfile.gem 'minitest-focus'
      gemfile.gem 'contrast'
      gemfile.gem 'mocha'
    end

    gemfile.group :test do
      gemfile.gem 'webmock'
      gemfile.gem 'timecop'
    end

    gemfile.group :development do
      gemfile.gem 'meta_request'
      gemfile.gem "better_errors"
      gemfile.gem "binding_of_caller"
    end

    gemfile.gem 'roland', git: 'git@github.com:SingularitySolutionsGroup/roland.git', tag: '1.0.2'

  end

end

gem 'willow', git: "git@github.com:SingularitySolutionsGroup/willow.git", tag: '4.0.10'
#gem 'willow', path: '~/willow'

if repo = ENV['CLIENT_SPECIFIC_GEM_REPO']
  protocol = repo.start_with?('git') ? 'git' : 'path'
  gem 'clientspecific', protocol => ENV['CLIENT_SPECIFIC_GEM_REPO']
end

WillowDependencies.load_my_dependencies self
