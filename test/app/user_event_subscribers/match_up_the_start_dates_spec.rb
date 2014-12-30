require_relative '../../minitest_helper'

describe MatchUpTheStartDates do

  let(:subscriber) { MatchUpTheStartDates.new }


  it "should be an user event subscriber" do
    subscriber.is_a?(UserEventSubscriber).must_equal true
  end

  describe "subscribed to?" do
    it "should return true for submitted_form" do
      user_event = Struct.new(:event_type).new 'submitted_form'
      result = MatchUpTheStartDates.subscribed_to?(user_event)
      result.must_equal true
    end

    it "should return false for others" do
      MatchUpTheStartDates
        .subscribed_to?(Struct.new(:event_type).new('others'))
        .must_equal false
      MatchUpTheStartDates
        .subscribed_to?(Struct.new(:event_type).new('something_else'))
        .must_equal false
    end
  end

  describe "go" do

    describe "the user has no lead data" do

      let(:user) { Struct.new(:hive_lead_id).new(Object.new) }

      before do
        subscriber.stubs(:user).returns user
        HiveApi.stubs(:find_by_hive_lead_id).with(user.hive_lead_id).returns nil
      end

      it "should not throw an error" do
        subscriber.go
      end

    end

    describe "the user has lead data" do

      let(:user) { Struct.new(:hive_lead_id).new(Object.new) }
      let(:lead) { { 'data' => lead_data } }
      let(:lead_data) { {} }

      before do
        subscriber.stubs(:user).returns user
        HiveApi.stubs(:find_by_hive_lead_id).with(user.hive_lead_id).returns lead
      end

      describe "and the program_of_interest.anticipated_start_date is set" do

        let(:anticipated_start_date) { Object.new }

        before do
          lead_data['program_of_interest.anticipated_start_date'] = anticipated_start_date
        end

        [nil, '', ' '].each do |not_set_value|
          describe "and the start date is not set" do
            before { lead_data['start_date'] = not_set_value }

            it "should set the start date to the anticipated start date" do
              HiveApi.expects(:update_lead_record_data).with(user.hive_lead_id, { 'start_date' => anticipated_start_date } )
              subscriber.go
            end
          end
        end

        describe "and the start date is set" do
          before { lead_data['start_date'] = Object.new }

          it "should set the start date to the anticipated start date" do
            HiveApi.expects(:update_lead_record_data).never
            subscriber.go
          end
        end

      end

      describe "and the start_date is set" do

        let(:start_date) { Object.new }

        before do
          lead_data['start_date'] = start_date
        end

        [nil, '', ' '].each do |not_set_value|
          describe "and the program_of_interest.anticipated_start_date is not set" do
            before { lead_data['program_of_interest.anticipated_start_date'] = not_set_value }

            it "should set the start date to the anticipated start date" do
              HiveApi.expects(:update_lead_record_data).with(user.hive_lead_id, { 'program_of_interest.anticipated_start_date' => start_date } )
              subscriber.go
            end
          end
        end

        describe "and the start date is set" do
          before { lead_data['program_of_interest.anticipated_start_date'] = Object.new }

          it "should set the start date to the anticipated start date" do
            HiveApi.expects(:update_lead_record_data).never
            subscriber.go
          end
        end

      end

    end

  end

end
