require_relative '../../minitest_helper'

class TestSetProgramInfoRule
  include SetProgramInfoRule
end

describe SetProgramInfoRule do
  it "should be an application modifier rule" do
    TestSetProgramInfoRule.new.is_a?(ApplicationModifierRule).must_equal true
  end

  describe "run" do

    let(:lead)        { { 'data' => {} } }
    let(:application) { Struct.new(:steps).new steps }

    let(:program_of_interest) { random_string }

    let(:steps) do
      [
        Struct.new(:tags, :form_id, :error_text, :is_hidden, :status).new([random_string, random_string, random_string],      nil, nil),
        Struct.new(:tags, :form_id, :error_text, :is_hidden, :status).new([SetProgramInfoRule::TAG, random_string, random_string], nil, nil),
        Struct.new(:tags, :form_id, :error_text, :is_hidden, :status).new([random_string, SetProgramInfoRule::TAG, random_string], nil, nil),
        Struct.new(:tags, :form_id, :error_text, :is_hidden, :status).new([random_string, random_string, SetProgramInfoRule::TAG], nil, nil),
        Struct.new(:tags, :form_id, :error_text, :is_hidden, :status).new([random_string, random_string, random_string],      nil, nil),
      ].sort_by { |x| random_string }
    end

    before do
      lead['data']['program_of_interest'] = program_of_interest
    end

    describe "and a form exists with a matching program" do

      let(:form_id) { Object.new }
      let(:form)    { Struct.new(:id).new form_id }

      before do
        Form.stubs(:where).with(name: "BU - Program Info - #{program_of_interest}").returns [form]
      end

      it "should set the form id" do
        SetProgramInfoRule.run lead, application
        steps_with_tags    = steps.select { |x| x.tags.include?(SetProgramInfoRule::TAG) }
        steps_without_tags = steps.reject { |x| x.tags.include?(SetProgramInfoRule::TAG) }

        steps_with_tags.each { |s| s.form_id.must_equal form_id }
        steps_without_tags.each { |s| s.form_id.nil?.must_equal true }
      end
    end

    describe "and a form does not exist with a matching campus location" do

      before do
        Form.stubs(:where).returns []
      end

      it "should not set any form id" do
        SetProgramInfoRule.run lead, application

        steps.select do |step|
          step.form_id.nil?.must_equal true
        end
      end

      it "should mark the step as completed" do
        SetProgramInfoRule.run lead, application

        steps_with_tags    = steps.select { |x| x.tags.include?(SetProgramInfoRule::TAG) }
        steps_without_tags = steps.reject { |x| x.tags.include?(SetProgramInfoRule::TAG) }

        steps_with_tags.each do |step|
          step.status.must_equal "Complete"
        end
        steps_without_tags.each do |step|
          step.status.nil?.must_equal true
        end
      end

      it "should mark the step as hidden" do
        SetProgramInfoRule.run lead, application

        steps_with_tags    = steps.select { |x| x.tags.include?(SetProgramInfoRule::TAG) }
        steps_without_tags = steps.reject { |x| x.tags.include?(SetProgramInfoRule::TAG) }

        steps_with_tags.each do |step|
          step.is_hidden.must_equal true
        end
        steps_without_tags.each do |step|
          step.status.nil?.must_equal true
        end
      end

    end

    describe "obviously bad inputs" do
      it "should not throw an error" do
        SetProgramInfoRule.run nil, application
        SetProgramInfoRule.run({}, application)
        SetProgramInfoRule.run lead, nil
      end
    end

  end

end
