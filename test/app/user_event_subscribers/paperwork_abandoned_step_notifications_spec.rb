require_relative '../../minitest_helper'

describe PaperworkAbandonedStepNotifications do

  let(:subscriber) { PaperworkAbandonedStepNotifications.new }

  it "should be an user event subscriber" do
    subscriber.is_a?(UserEventSubscriber).must_equal true
  end

  describe "subscribed to?" do
    it "should return true for step_state_set" do
      user_event = Struct.new(:event_type).new 'step_state_set'
      result = PaperworkAbandonedStepNotifications.subscribed_to?(user_event)
      result.must_equal true
    end

    it "should return false for others" do
      PaperworkAbandonedStepNotifications
        .subscribed_to?(Struct.new(:event_type).new('others'))
        .must_equal false
      PaperworkAbandonedStepNotifications
        .subscribed_to?(Struct.new(:event_type).new('something_else'))
        .must_equal false
    end
  end

  describe "doing the work" do

    let(:application) { Object.new }
    let(:user_event)  { Struct.new(:user_id, :user_application_id).new Object.new, Object.new }

    before do
      subscriber.stubs(:application).returns application
      subscriber.stubs(:user_event).returns user_event
      application.stubs(:get_next_step).returns next_step
    end

    describe "and the next step includes a tag of paperwork abandoned" do

      let(:tags)      { ['d', 'notify_on_paperwork_abandoned', 'e'] }
      let(:flow)      { Object.new }
      let(:next_step) { Struct.new(:tags).new tags }

      before do
        subscriber.stubs(:flow).returns flow
      end

      describe "and the paperwork abandoned step has never been set on this user" do

        describe "multiple examples" do

          before do
            application.stubs(:data).returns( { 'paperwork_abandoned_workflow_was_set' => nil } )
            flow.stubs(:start)
            application.stubs(:set_data_value)
          end

          it "should start the paperwork abandoned flow" do
            flow.expects(:start).with( { user_id: user_event.user_id,
                                         user_application_id: user_event.user_application_id } )
            subscriber.go
          end

          it "should set a flag on the application so we know the workflow was set up" do
            application.expects(:set_data_value).with('paperwork_abandoned_workflow_was_set', '1')
            subscriber.go
          end

        end

      end

      describe "and the paperwork abandoned step has set on this user before" do

        before do
          application.stubs(:data).returns( { 'paperwork_abandoned_workflow_was_set' => true } )
        end

        it "should start the paperwork abandoned flow" do
          flow.expects(:start).never
          subscriber.go
        end

      end

    end

    describe "and the next step does not include a tag of paperwork abandoned" do

      let(:tags)      { ['d', 'f', 'e'] }
      let(:flow)      { Object.new }
      let(:next_step) { Struct.new(:tags).new tags }

      before do
        subscriber.stubs(:flow).returns flow
      end

      describe "and the paperwork abandoned step has never been run on this user" do

        before do
          application.stubs(:data).returns( { random_string => random_string } )
        end

        it "should start the paperwork abandoned flow" do
          flow.expects(:start).never
          subscriber.go
        end

      end

    end

    describe "and there is no next step" do

      let(:next_step) { nil }
      let(:flow)      { Object.new }

      before do
        subscriber.stubs(:flow).returns flow
      end

      it "should start the paperwork abandoned flow" do
        flow.expects(:start).never
        subscriber.go
      end

    end

  end

  describe "the workflow" do

    it "should wait three days, then check for more paperwork steps, then email again" do

      flow = PaperworkAbandonedStepNotifications.new.flow

      flow.steps.count.must_equal 3

      flow.steps[0].name.must_equal "wait"
      flow.steps[0].arguments.must_equal [3.days]

      flow.steps[1].name.must_equal "check_that_paperwork_was_provided"

      flow.steps[2].name.must_equal "send_email_asking_for_student_to_come_back_for_paperwork"

    end

  end

end
