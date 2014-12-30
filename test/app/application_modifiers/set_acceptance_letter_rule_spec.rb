require_relative '../../minitest_helper'

class TestAcceptanceLetterRule
  include SetAcceptanceLetterRule
end

describe SetAcceptanceLetterRule do

  it "should be an application modifier rule" do
    TestAcceptanceLetterRule.new.is_a?(ApplicationModifierRule).must_equal true
  end

  describe "run" do

    let(:lead)        { { 'data' => {} } }
    let(:application) { Struct.new(:steps).new steps }

    let(:campus_of_interest) { random_string }

    before do
      lead['data']['campus_of_interest'] = campus_of_interest
    end

    let(:steps) do
      [
        Struct.new(:tags, :form_id, :error_text, :is_hidden, :status).new([random_string, random_string, random_string],           nil, nil, nil, nil),
        Struct.new(:tags, :form_id, :error_text, :is_hidden, :status).new([SetAcceptanceLetterRule::TAG, random_string, random_string], nil, nil, nil, nil),
        Struct.new(:tags, :form_id, :error_text, :is_hidden, :status).new([random_string, SetAcceptanceLetterRule::TAG, random_string], nil, nil, nil, nil),
        Struct.new(:tags, :form_id, :error_text, :is_hidden, :status).new([random_string, random_string, SetAcceptanceLetterRule::TAG], nil, nil, nil, nil),
        Struct.new(:tags, :form_id, :error_text, :is_hidden, :status).new([random_string, random_string, random_string],           nil, nil, nil, nil),
      ].sort_by { |x| random_string }
    end

    describe "and a form exists with a matching campus location" do

      let(:form_id) { Object.new }
      let(:form)    { Struct.new(:id).new form_id }

      before do
        Form.stubs(:where).with("name ilike ?", "BU - Exec Director Acceptance Letter (#{campus_of_interest})").returns [form]
      end

      it "should set the form id" do
        SetAcceptanceLetterRule.run lead, application
        steps_with_tags    = steps.select { |x| x.tags.include?(SetAcceptanceLetterRule::TAG) }
        steps_without_tags = steps.reject { |x| x.tags.include?(SetAcceptanceLetterRule::TAG) }

        steps_with_tags.each { |s| s.form_id.must_equal form_id }
        steps_without_tags.each { |s| s.form_id.nil?.must_equal true }
      end
    end

    describe "and a form does not exist with a matching campus location" do

      before do
        Form.stubs(:where).returns []
      end

      it "should not set any form id" do
        SetAcceptanceLetterRule.run lead, application

        steps.select do |step|
          step.form_id.nil?.must_equal true
        end
      end

      it "should set the error text on the step" do
        SetAcceptanceLetterRule.run lead, application

        steps_with_tags    = steps.select { |x| x.tags.include?(SetAcceptanceLetterRule::TAG) }
        steps_without_tags = steps.reject { |x| x.tags.include?(SetAcceptanceLetterRule::TAG) }

        steps_with_tags.each do |step|
          step.error_text.must_equal SetAcceptanceLetterRule::ERROR_MESSAGE
        end
        steps_without_tags.each do |step|
          step.error_text.nil?.must_equal true
        end
      end

      it "should set the step to hidden" do
        SetAcceptanceLetterRule.run lead, application

        steps_with_tags    = steps.select { |x| x.tags.include?(SetAcceptanceLetterRule::TAG) }
        steps_without_tags = steps.reject { |x| x.tags.include?(SetAcceptanceLetterRule::TAG) }

        steps_with_tags.each do |step|
          step.is_hidden.must_equal true
        end
        steps_without_tags.each do |step|
          step.is_hidden.nil?.must_equal true
        end
          
      end

      it "should mark the step as Complete" do
        SetAcceptanceLetterRule.run lead, application

        steps_with_tags    = steps.select { |x| x.tags.include?(SetAcceptanceLetterRule::TAG) }
        steps_without_tags = steps.reject { |x| x.tags.include?(SetAcceptanceLetterRule::TAG) }

        steps_with_tags.each do |step|
          step.status.must_equal 'Complete'
        end
        steps_without_tags.each do |step|
          step.status.nil?.must_equal true
        end
          
      end

    end

    describe "obviously bad inputs" do
      it "should not throw an error" do
        SetAcceptanceLetterRule.run nil, application
        SetAcceptanceLetterRule.run({}, application)
        SetAcceptanceLetterRule.run lead, nil
      end
    end

  end

end
