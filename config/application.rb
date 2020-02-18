require File.expand_path('../boot', __FILE__)

require 'rails/all'

require 'willow'
require 'source_code'
Willow.require_everything
require 'clientspecific' if ENV['CLIENT_SPECIFIC_GEM_REPO']

unless Object.const_defined?('ClientConfiguration')
  class ClientConfiguration
   def self.site_url
      ENV['STUDENT_PORTAL_URL']
    end

    def self.school_name
      'First Institute'
    end

    def self.assets_directory
      'conduit'
    end

    def self.email_prefix
      'first-inst-student-portal'
    end
  end
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
#Bundler.require(*Rails.groups)
Bundler.require('willow', 'seam-active_record')

module ConduitBryan
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true

    config.generators do |g|
      g.orm :active_record
    end

    config.after_initialize do
      ClientSpecificSetup.setup if Object.const_defined?('ClientSpecificSetup')
    end

    if ENV["FILEPICKER_API_KEY"]
      config.filepicker_rails.api_key = ENV["FILEPICKER_API_KEY"]
    end

    if gem = ENV['CLIENT_SPECIFIC_GEM_REPO']
      config.paths['db/migrate'] << "#{`bundle show clientspecific`.strip}/db/migrate"
    end

  end
end
