require_relative '../../minitest_helper'

describe StudentManagementController do

  let(:controller) { StudentManagementController.new }

  describe "a reason the new user is invalid" do

    let(:params)     { {} }

    let(:result) { controller.a_reason_the_new_user_is_invalid(nil, params) }

    describe "but no lead id was provided" do

      it "should return nil" do
        result.nil?.must_equal true
      end

    end

    [:lead_id, :hive_lead_id].each do |field|

      describe "and a lead id was provided" do

        let(:lead_id) { random_string }

        before do
          params[field] = lead_id
        end

        describe "and that lead id was used before" do

          before do
            Refinery::User.stubs(:where).with(hive_lead_id: lead_id).returns [Object.new]
          end

          it "should return a message saying the user already exists" do
            result = controller.a_reason_the_new_user_is_invalid nil, params
            result.must_equal 'A user exists with this lead id.'
          end

        end

        describe "and that lead id was NOT used before" do

          before do
            Refinery::User.stubs(:where).with(hive_lead_id: lead_id).returns []
          end

          it "should return nothing" do
            result = controller.a_reason_the_new_user_is_invalid nil, params
            result.nil?.must_equal true
          end

        end

      end

    end

  end

end
