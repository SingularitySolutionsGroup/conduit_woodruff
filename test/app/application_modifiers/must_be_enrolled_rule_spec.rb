require_relative '../../minitest_helper'

class TestMustBeEnrolledRule
  include MustBeEnrolledRule
end

describe MustBeEnrolledRule do

  it "should be a CompleteStepBasedOnVelocifyStatus" do
    TestMustBeEnrolledRule.new.is_a?(CompleteStepBasedOnVelocifyStatus).must_equal true
  end

  it "should be a ApplicationModifierRule" do
    TestMustBeEnrolledRule.new.is_a?(ApplicationModifierRule).must_equal true
  end

  it "should have a tag of Must Be Enrolled" do
    MustBeEnrolledRule.tag.must_equal "Must Be Enrolled"
  end

  it "should have a status of Enrolled" do
    MustBeEnrolledRule.status.must_equal "Enrolled"
  end

end
