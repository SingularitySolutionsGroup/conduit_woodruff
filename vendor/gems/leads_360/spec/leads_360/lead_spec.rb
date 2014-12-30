require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Leads360::Lead do
  it "should exist" do
    Leads360::Lead.nil?.must_equal false
  end
end
