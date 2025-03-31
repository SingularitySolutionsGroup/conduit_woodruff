ENV['RACK_ENV'] = 'test'
ENV['RAILS_ENV'] = 'test'

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/focus'
require 'contrast'
require 'subtle'
require File.expand_path(File.dirname(__FILE__) + '/../config/environment')
require "mocha/setup"
require 'timecop'
require 'webmock/minitest'

MiniTest::Reporters.use! if ENV['IAM'] == 'ferris'

def random_string
  SecureRandom.uuid
end

def random_integer
  (1...1000).to_a.sample
end
