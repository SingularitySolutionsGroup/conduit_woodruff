ENV['RACK_ENV'] = 'test'
ENV['RAILS_ENV'] = 'test'

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/focus'
require 'contrast'
require 'subtle'
require "mocha/setup"
require 'timecop'
require 'webmock/minitest'

MiniTest::Reporters.use! if ENV['IAM'] == 'ferris'
