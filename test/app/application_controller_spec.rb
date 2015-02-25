require_relative '../minitest_helper'

describe ApplicationController do
  it "should be a Willow Controller" do
    ApplicationController.new.is_a?(WillowController).must_equal true
  end
end
