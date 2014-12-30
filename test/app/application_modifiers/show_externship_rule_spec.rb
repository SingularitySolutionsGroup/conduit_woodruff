require_relative '../../minitest_helper'

class TestShowExternshipRules
  include ShowExternshipRule
end

describe ShowExternshipRule do
  it "should be an application modifier rule" do
    TestShowExternshipRules.new.is_a?(ApplicationModifierRule).must_equal true
  end

  describe "run" do

    let(:lead)        { { 'data' => {} } }
    let(:application) { Struct.new(:steps).new steps }

    let(:steps) do
      [
        Struct.new(:tags, :status, :is_hidden).new([random_string,          random_string,          random_string],          "", false),
        Struct.new(:tags, :status, :is_hidden).new([ShowExternshipRule.tag, random_string,          random_string],          "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string,          ShowExternshipRule.tag, random_string],          "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string,          random_string,          ShowExternshipRule.tag], "", false),
        Struct.new(:tags, :status, :is_hidden).new([random_string,          random_string,          random_string],          "", false),
      ].sort_by { |x| random_string }
    end

    describe "the program is is eligible for externship" do

      before do
        campus = Object.new
        program = Object.new
        lead['data']['campus_of_interest']  = campus
        lead['data']['program_of_interest'] = program
        Externship.stubs(:required_for?).with(campus, program).returns true
      end

      it "should not complete any steps" do
        ShowExternshipRule.run lead, application
        steps.select { |x| x.status == "Complete" }.count.must_equal 0
      end

      it "should hide the ground only steps" do
        ShowExternshipRule.run lead, application
        steps.select { |x| x.is_hidden }.count.must_equal 0
      end
    end

    describe "the program is NOT eligible for externship" do

      before do
        campus = Object.new
        program = Object.new
        lead['data']['campus_of_interest']  = campus
        lead['data']['program_of_interest'] = program
        Externship.stubs(:required_for?).with(campus, program).returns false
      end

      it "should complete the show externship steps" do
        ShowExternshipRule.run lead, application
        steps.select { |x| x.status == "Complete" && x.tags.include?(ShowExternshipRule.tag) }.count.must_equal 3
      end

      it "should hide the ground only steps" do
        ShowExternshipRule.run lead, application
        steps.select { |x| x.is_hidden && x.tags.include?(ShowExternshipRule.tag) }.count.must_equal 3
      end

    end

    describe "bad inputs" do
      it "should not throw an exception" do
        ShowExternshipRule.run nil,  application
        ShowExternshipRule.run({},   application)
        ShowExternshipRule.run lead, nil
      end
    end

  end

end
