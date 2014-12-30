require File.expand_path(File.dirname(__FILE__) + '/../../minitest_helper')

describe StudentManagementController do

  let(:controller) { StudentManagementController.new }

  describe "a reason the new user is invalid" do

    [:lead_id, :hive_lead_id].each do |field|

      describe "multiple ways to look for lead id (#{field})" do

        describe "and a user already exists with this lead id" do

          let(:lead_id) { Object.new }

          before do
            Refinery::User.stubs(:where).with(hive_lead_id: lead_id).returns [Object.new]
          end

          it "should report that a user exists with this lead id" do
            result = controller.a_reason_the_new_user_is_invalid nil, { field => lead_id }
            result.must_equal 'A user exists with this lead id.'
          end

        end

        describe "and a user does not exist with this lead id" do

          let(:lead_id) { Object.new }

          before do
            Refinery::User.stubs(:where).with(hive_lead_id: lead_id).returns []
          end

          it "should report that a user exists with this lead id" do
            result = controller.a_reason_the_new_user_is_invalid nil, { lead_id: lead_id }
            result.nil?.must_equal true
          end

        end

      end

    end

  end

end
