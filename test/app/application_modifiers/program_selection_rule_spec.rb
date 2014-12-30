require_relative '../../minitest_helper'

class TestProgramSelectionRule
  include ProgramSelectionRule
end

describe ProgramSelectionRule do

  it "should be an application modifier rule" do
    TestProgramSelectionRule.new.is_a?(ApplicationModifierRule).must_equal true
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
        Struct.new(:tags, :form_id, :is_hidden, :status).new([random_string, random_string, random_string],       nil, nil, nil),
        Struct.new(:tags, :form_id, :is_hidden, :status).new(['Program Selection', random_string, random_string], nil, nil, nil),
        Struct.new(:tags, :form_id, :is_hidden, :status).new([random_string, 'Program Selection', random_string], nil, nil, nil),
        Struct.new(:tags, :form_id, :is_hidden, :status).new([random_string, random_string, 'Program Selection'], nil, nil, nil),
        Struct.new(:tags, :form_id, :is_hidden, :status).new([random_string, random_string, random_string],       nil, nil, nil),
      ].sort_by { |x| random_string }
    end

    describe "has no ps items" do
      it "should hide the step" do
        ProgramSelectionRule.run lead, application
        steps_with_tags    = steps.select { |x| x.tags.include?('Program Selection') }
        steps_without_tags = steps.reject { |x| x.tags.include?('Program Selection') }

        steps_with_tags.each    { |s| s.is_hidden.must_equal true }
        steps_without_tags.each { |s| s.is_hidden.nil?.must_equal true }
      end

      it "should mark the step as complete" do
        ProgramSelectionRule.run lead, application
        steps_with_tags    = steps.select { |x| x.tags.include?('Program Selection') }
        steps_without_tags = steps.reject { |x| x.tags.include?('Program Selection') }

        steps_with_tags.each    { |s| s.status.must_equal 'Complete' }
        steps_without_tags.each { |s| s.status.nil?.must_equal true }
      end
    end

    describe "and the lead data has a number of 'ps' items, with one item having more than others" do

      let(:ps_item) { random_string }

      before do
        lead['data']["ps_#{random_string}_1"] = true

        second = random_string
        lead['data']["ps_#{second}_1"] = true
        lead['data']["ps_#{second}_2"] = true

        lead['data']["ps_#{ps_item}_1"] = true
        lead['data']["ps_#{ps_item}_2"] = true
        lead['data']["ps_#{ps_item}_3"] = true
        lead['data']["ps_#{ps_item}_a"] = true

        lead['data']["ps_#{random_string}_1"] = true
        lead['data']["ps_#{random_string}_1"] = true
      end

      describe "and a form exists that matches the ps item" do

        let(:form_id) { Object.new }
        let(:form)    { Struct.new(:id).new form_id }

        before do
          Form.stubs(:where).with("name ilike ?", "BU - Program Selection (#{ps_item.upcase})").returns [form]
        end

        it "should set the form id" do
          ProgramSelectionRule.run lead, application
          steps_with_tags    = steps.select { |x| x.tags.include?('Program Selection') }
          steps_without_tags = steps.reject { |x| x.tags.include?('Program Selection') }

          steps_with_tags.each    { |s| s.form_id.must_equal form_id }
          steps_without_tags.each { |s| s.form_id.nil?.must_equal true }
        end

        describe "and there are some ps items that do not follow the proper naming conventions" do

          before do
            lead['data']["ps_"] = true
            lead['data']["ps_#{random_string}"] = true
          end

          it "should still set the form id" do
            ProgramSelectionRule.run lead, application
            steps_with_tags    = steps.select { |x| x.tags.include?('Program Selection') }
            steps_without_tags = steps.reject { |x| x.tags.include?('Program Selection') }

            steps_with_tags.each    { |s| s.form_id.must_equal form_id }
            steps_without_tags.each { |s| s.form_id.nil?.must_equal true }
          end

        end

        describe "and there is one ps_item with more items, but they are false instead of true" do

          before do
            key = random_string
            lead['data']["ps_#{key}_1"] = false
            lead['data']["ps_#{key}_2"] = false
            lead['data']["ps_#{key}_3"] = false
            lead['data']["ps_#{key}_4"] = false
            lead['data']["ps_#{key}_5"] = false
            lead['data']["ps_#{key}_6"] = false
            lead['data']["ps_#{key}_7"] = false
            lead['data']["ps_#{key}_8"] = true
            lead['data']["ps_#{key}_9"] = false
            lead['data']["ps_#{key}_10"] = true
          end

          it "should set the form id to the one with more trues" do
            ProgramSelectionRule.run lead, application
            steps_with_tags    = steps.select { |x| x.tags.include?('Program Selection') }
            steps_without_tags = steps.reject { |x| x.tags.include?('Program Selection') }

            steps_with_tags.each    { |s| s.form_id.must_equal form_id }
            steps_without_tags.each { |s| s.form_id.nil?.must_equal true }
          end

          describe "and the value set is 'Yes', not true" do

            before do
              lead['data'].each do |key, value|
                lead['data'][key] = 'Yes' if value
                lead['data'][key] = 'No'  unless value
              end
            end

            it "should still set the form id" do
              ProgramSelectionRule.run lead, application
              steps_with_tags    = steps.select { |x| x.tags.include?('Program Selection') }
              steps_without_tags = steps.reject { |x| x.tags.include?('Program Selection') }

              steps_with_tags.each    { |s| s.form_id.must_equal form_id }
              steps_without_tags.each { |s| s.form_id.nil?.must_equal true }
            end

          end

        end

      end

      describe "and a form does not exist that matches the ps item" do

        before do
          Form.stubs(:where).returns []
        end

        it "should hide the step" do
          ProgramSelectionRule.run lead, application
          steps_with_tags    = steps.select { |x| x.tags.include?('Program Selection') }
          steps_without_tags = steps.reject { |x| x.tags.include?('Program Selection') }

          steps_with_tags.each    { |s| s.is_hidden.must_equal true }
          steps_without_tags.each { |s| s.is_hidden.nil?.must_equal true }
        end

        it "should mark the step as complete" do
          ProgramSelectionRule.run lead, application
          steps_with_tags    = steps.select { |x| x.tags.include?('Program Selection') }
          steps_without_tags = steps.reject { |x| x.tags.include?('Program Selection') }

          steps_with_tags.each    { |s| s.status.must_equal 'Complete' }
          steps_without_tags.each { |s| s.status.nil?.must_equal true }
        end

      end

    end

    describe "with obviously bad inputs" do
      it "should not throw an exception" do
        ProgramSelectionRule.run nil,  application
        ProgramSelectionRule.run({},   application)
        ProgramSelectionRule.run lead, nil
      end
    end

  end

end
