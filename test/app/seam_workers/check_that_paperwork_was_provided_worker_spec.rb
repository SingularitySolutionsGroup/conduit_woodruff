require_relative '../../minitest_helper'

describe "check that paperwork was provided" do

  let(:worker) { CheckThatPaperworkWasProvidedWorker.new }

  it "should be a seam worker" do
    worker.is_a?(Seam::Worker).must_equal true
  end

  describe "process" do


    let(:user_id)             { random_string }
    let(:user_application_id) { random_string }

    let(:application) { Object.new }
    let(:user)        { Object.new }

    let(:effort) do
      Struct.new(:data).new ( { 'user_id' => user_id,
                                'user_application_id' => user_application_id } )
    end

    before do
      Refinery::User.stubs(:find).with(user_id).returns user
      user.stubs(:get_application).with(user_application_id).returns application

      application.stubs(:get_steps_by_tag)
                 .with('notify_on_paperwork_abandoned').returns steps

      worker.stubs(:effort).returns effort
    end

    describe "the user application has no incomplete steps with the tag" do

      let(:steps) do 
        [
          Struct.new(:student_application_state).new(Object.new),
          Struct.new(:student_application_state).new(Object.new),
        ]
      end

      it "should eject the workflow" do
        worker.expects(:eject)
        worker.process
      end

    end

    describe "the user application has incomplete steps with the tag" do

      let(:steps) do 
        [
          Struct.new(:student_application_state).new(Object.new),
          Struct.new(:student_application_state).new(nil),
          Struct.new(:student_application_state).new(Object.new),
        ]
      end

      it "should should not eject" do
        worker.expects(:eject).never
        worker.process
      end

    end

  end

end
