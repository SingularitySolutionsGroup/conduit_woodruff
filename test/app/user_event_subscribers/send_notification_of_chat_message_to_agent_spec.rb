require_relative '../../minitest_helper'

describe SendNotificationOfChatMessageToAgent do

  let(:subscriber) { SendNotificationOfChatMessageToAgent.new }

  it "should be an user event subscriber" do
    subscriber.is_a?(UserEventSubscriber).must_equal true
  end

  describe "subscribed to?" do
    it "should return true for sent_instant_message" do
      user_event = Struct.new(:event_type).new 'sent_instant_message'
      result = SendNotificationOfChatMessageToAgent.subscribed_to?(user_event)
      result.must_equal true
    end

    it "should return false for others" do
      user_event = Struct.new(:event_type).new random_string
      result = SendNotificationOfChatMessageToAgent.subscribed_to?(user_event)
      result.must_equal false
    end
  end

  describe "doing the work" do

    let(:application) { Object.new }
    let(:user_event)  { Struct.new(:user_id, :data).new Object.new, { message: random_string } }

    let(:user) { Struct.new(:id, :hive_lead_id, :first_name, :last_name).new Object.new, random_string, random_string, random_string }
    let(:data) { {} }

    before do
      subscriber.stubs(:user_event).returns user_event
      Refinery::User.stubs(:where).with(id: user_event.user_id).returns [user]
      HiveApi.stubs(:find_by_hive_lead_id).with(user.hive_lead_id).returns( { 'data' => data } )
    end

    describe "and a chat notification email does not exist" do

      before do
        NotificationProvider.stubs(:get_notification_by_tag).with('Chat Notification').returns nil
      end

      it "should not throw an error" do
        subscriber.go
      end

    end

    describe "and a chat notification email exists" do

      let(:notification) { Struct.new(:to_recipient_blocks).new nil }

      before do
        NotificationProvider.stubs(:get_notification_by_tag).with('Chat Notification').returns notification
      end

      describe "and no lead data exists" do
        before do
          HiveApi.stubs(:find_by_hive_lead_id).with(user.hive_lead_id).returns nil
        end

        it "should not throw an error" do
          subscriber.go
        end
      end

      describe "and no lead data block exists" do
        before do
          HiveApi.stubs(:find_by_hive_lead_id).with(user.hive_lead_id).returns({})
        end

        it "should not throw an error" do
          subscriber.go
        end
      end


      describe "and there is no agent email" do

        before do
          data['agent_email'] = nil
        end

        it "should not send a notification email" do
          NotificationSender.expects(:send_notification).never
          subscriber.go
        end

      end

      describe "and an agent_email is set in the data" do

        let(:agent_email) { random_string }

        before do
          data['agent_email'] = agent_email
        end

        it "should send the notification" do
          NotificationSender.expects(:send_notification).with do |n, _|
            n == notification
          end
          subscriber.go
        end

        it "should send it to the agent email" do
          NotificationSender.expects(:send_notification).with do |n, _|
            n.to_recipient_blocks == [ { email: agent_email } ]
          end
          subscriber.go
        end

        it "should pass along the user_name" do
          NotificationSender.expects(:send_notification).with do |_, data|
            data[:user_name].must_equal "#{user.first_name} #{user.last_name}"
          end
          subscriber.go
        end

        it "should pass along the message" do
          NotificationSender.expects(:send_notification).with do |_, data|
            data[:message] == user_event.data[:message]
          end
          subscriber.go
        end

        it "should pass along a url to get to that specific user" do
          NotificationSender.expects(:send_notification).with do |_, data|
            data[:url] == "https://portal.bryanu.edu/students/detail/#{user.id}"
          end
          subscriber.go
        end

      end

    end

  end

end
