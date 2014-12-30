require_relative '../../minitest_helper'

describe SendReferralsToVelocify do

  let(:subscriber) { SendReferralsToVelocify.new }

  it "should be an user event subscriber" do
    subscriber.is_a?(UserEventSubscriber).must_equal true
  end

  describe "subscribed to?" do
    it "should return true for made_referral" do
      user_event = Struct.new(:event_type).new 'made_referral'
      result = SendReferralsToVelocify.subscribed_to?(user_event)
      result.must_equal true
    end

    it "should return false for others" do
      SendReferralsToVelocify
        .subscribed_to?(Struct.new(:event_type).new('others'))
        .must_equal false
      SendReferralsToVelocify
        .subscribed_to?(Struct.new(:event_type).new('something_else'))
        .must_equal false
    end
  end

  describe "go" do

    let(:key)          { random_string }
    let(:value)        { random_string }
    let(:data)         { { key => value } }
    let(:user_event)   { Struct.new(:data).new data }
    let(:lead_creator) { Object.new }

    let(:user) do
      Struct.new(:first_name, :last_name, :hive_lead_id)
            .new(random_string, random_string, random_string)
    end

    let(:lead_data) { {} }

    before do
      Leads360::LeadCreator.stubs(:new).returns lead_creator
      subscriber.stubs(:user_event).returns user_event
      subscriber.stubs(:user).returns user
      lead_creator.stubs(:add_lead)

      HiveApi.stubs(:find_by_hive_lead_id)
             .with(user.hive_lead_id)
             .returns( { 'data' => lead_data } )
    end

    it "should send the referral data to velocify" do
      lead_creator.expects(:add_lead).with do |data|
        data[key] == value
      end
      subscriber.go
    end

    it "should hardcode the campaign to 1581" do
      lead_creator.expects(:add_lead).with do |data|
        data['campaign_id'] == '1581'
      end
      subscriber.go
    end

    it "should send a comment that the user created the " do
      u = user
      lead_creator.expects(:add_lead).with do |data|
        data['comment'] == "Referred by #{u.first_name} #{u.last_name} (#{u.hive_lead_id})."
      end
      subscriber.go
    end

    it "should pass the users campus of interest" do
      campus_of_interest = Object.new
      lead_data['campus_of_interest'] = campus_of_interest
      lead_creator.expects(:add_lead).with do |data|
        data['campus_of_interest'] == campus_of_interest
      end
      subscriber.go
    end

    describe "there is no lead data for the user" do

      before do
        HiveApi.stubs(:find_by_hive_lead_id)
               .with(user.hive_lead_id)
               .returns nil
      end

      it "should send nothing for campus of interest" do
        lead_creator.expects(:add_lead).with do |data|
          data['campus_of_interest'].nil?
        end
        subscriber.go
      end

    end

    describe "there is no lead data -> data for the user" do

      before do
        HiveApi.stubs(:find_by_hive_lead_id)
               .with(user.hive_lead_id)
               .returns({})
      end

      it "should send nothing for campus of interest" do
        lead_creator.expects(:add_lead).with do |data|
          data['campus_of_interest'].nil?
        end
        subscriber.go
      end

    end

  end

end
