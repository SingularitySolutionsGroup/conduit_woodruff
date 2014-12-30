require_relative '../../minitest_helper'

class TestMustHaveInterviewed
  include MustHaveInterviewedRule
end

describe MustHaveInterviewedRule do
  it "should be an application modifier rule" do
    TestMustHaveInterviewed.new.is_a?(ApplicationModifierRule).must_equal true
  end

  describe "run" do

    let(:lead)        { { 'data' => {} } }
    let(:application) { Struct.new(:steps).new steps }

    let(:steps) do
      [
        Struct.new(:tags, :status, :is_hidden).new([random_string, random_string, random_string], "", false),
        Struct.new(:tags, :status, :is_hidden).new(["Must Have Interviewed", random_string, random_string], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string, "Must Have Interviewed", random_string], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string, random_string, "Must Have Interviewed"], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string, random_string, random_string], "", false),
      ].sort_by { |x| random_string }
    end

    describe "the lead is currently interviewed" do
      before do
        lead['data']['status_title'] = "Interviewed"
      end

      it "should complete the tagged steps" do
        MustHaveInterviewedRule.run lead, application
        steps.select { |x| x.status == "Complete" }.count.must_equal 3
        steps.select { |x| x.status == "Complete" && x.tags.include?("Must Have Interviewed") }.count.must_equal 3
      end

      it "should NOT hide the tagged steps" do
        MustHaveInterviewedRule.run lead, application
        steps.select { |x| x.is_hidden }.count.must_equal 0
        steps.select { |x| x.is_hidden && x.tags.include?("Must Have Interviewed") }.count.must_equal 0
      end
    end

    describe "the lead has gone through the interviewed step at some point" do
      before do
        lead['data']['status_logs'] = [ 
                                        { "status_title"=> random_string },
                                        { "status_title"=> "Interviewed" },
                                        { "status_title"=> random_string }
                                      ].sort_by { |x| random_string }
      end

      it "should complete the tagged steps" do
        MustHaveInterviewedRule.run lead, application
        steps.select { |x| x.status == "Complete" }.count.must_equal 3
        steps.select { |x| x.status == "Complete" && x.tags.include?("Must Have Interviewed") }.count.must_equal 3
      end

      it "should NOT hide the tagged steps" do
        MustHaveInterviewedRule.run lead, application
        steps.select { |x| x.is_hidden }.count.must_equal 0
        steps.select { |x| x.is_hidden && x.tags.include?("Must Have Interviewed") }.count.must_equal 0
      end
    end

    describe "the lead has NOT gone through the interviewed step at some point" do
      before do
        lead['data']['status_logs'] = [ 
                                        { "status_title"=> random_string },
                                        { "status_title"=> random_string },
                                        { "status_title"=> random_string }
                                      ].sort_by { |x| random_string }
      end

      it "should not complete the tagged steps" do
        MustHaveInterviewedRule.run lead, application
        steps.select { |x| x.status == "Complete" }.count.must_equal 0
        steps.select { |x| x.status == "Complete" && x.tags.include?("Must Have Interviewed") }.count.must_equal 0
      end

      it "should NOT hide the tagged steps" do
        MustHaveInterviewedRule.run lead, application
        steps.select { |x| x.is_hidden }.count.must_equal 0
        steps.select { |x| x.is_hidden && x.tags.include?("Must Have Interviewed") }.count.must_equal 0
      end
    end

    describe "bad inputs" do
      it "should not throw an error" do
        MustHaveInterviewedRule.run nil, application
        MustHaveInterviewedRule.run({}, application)
        MustHaveInterviewedRule.run lead, nil
      end
    end

  end

end
