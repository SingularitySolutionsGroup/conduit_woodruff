require_relative '../../minitest_helper'

describe NoteReferrals do

  let(:subscriber) { NoteReferrals.new }

  it "should be a hook subscriber" do
    subscriber.is_a?(HookSubscriber).must_equal true
  end

  it "should be bound to the Note Referrals" do
    NoteReferrals.hook.must_equal "Note Referrals"
  end

  it "should respond to the complete event" do
    NoteReferrals.event.must_equal :complete
  end

  describe "go" do

    let(:hive_lead_id) { Object.new }

    let(:lead) { { 'data' => data } }
    let(:data) { { } }
    let(:user) { Struct.new(:hive_lead_id).new hive_lead_id }

    before do
      subscriber.stubs(:user).returns user
      HiveApi.stubs(:find_by_hive_lead_id)
        .with(hive_lead_id)
        .returns lead
      UserEvent.stubs(:made_referral)
    end

    describe "three swipes at a referral" do

      [1, 2, 3].each do |index|

        describe "and the user made the referral" do

          before do
            data["ref#{index}_first_name"] = random_string
            data["ref#{index}_last_name"]  = random_string
            data["ref#{index}_email"]      = random_string
            data["ref#{index}_phone"]      = random_string
          end

          it "should record the referral" do
            referral_data = { 
              "first_name" => data["ref#{index}_first_name"],
              "last_name"  => data["ref#{index}_last_name"],
              "email"      => data["ref#{index}_email"],
              "phone"      => data["ref#{index}_phone"],
            }
            UserEvent.expects(:made_referral).with user, referral_data
            subscriber.go
          end

        end

        describe "and the user did not make referral" do
          describe "the default values are nil" do
            it "should NOT record the referral" do
              UserEvent.stubs(:made_referral).raises 'should not have made the call'
              subscriber.go
            end
          end

          describe "the referrals is blank" do
            before do
              data["ref#{index}_first_name"] = ""
            end

            it "should NOT record the referral" do
              UserEvent.stubs(:made_referral).raises 'should not have made the call'
              subscriber.go
            end
          end

          describe "the referrals are white space" do
            before do
              data["ref#{index}_first_name"] = "     "
            end

            it "should NOT record the referral" do
              UserEvent.stubs(:made_referral).raises 'should not have made the call'
              subscriber.go
            end
          end
        end

      end

    end

  end

end

