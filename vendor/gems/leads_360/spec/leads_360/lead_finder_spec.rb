require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'date'

describe Leads360::LeadFinder do
  it "should exist" do
    Leads360::LeadFinder.nil?.must_equal false
  end

  describe "#new" do
    it "should be able to be instantiated with a username" do
      Leads360::LeadFinder.new( { username: 'username' } ).username.must_equal 'username'
      Leads360::LeadFinder.new( { username: 'apple' } ).username.must_equal 'apple'
      Leads360::LeadFinder.new( { username: 'orange' } ).username.must_equal 'orange'
    end

    it "should be able to be instantiated with a password" do
      Leads360::LeadFinder.new( { password: 'password' } ).password.must_equal 'password'
      Leads360::LeadFinder.new( { password: 'apple' } ).password.must_equal 'apple'
      Leads360::LeadFinder.new( { password: 'orange' } ).password.must_equal 'orange'
    end
  end
end
