require File.expand_path(File.dirname(__FILE__) + '/../../minitest_helper')

describe VelocifyUpdateIntegrationRequestWorker do

  let(:worker) { VelocifyUpdateIntegrationRequestWorker.new }

  it "should be a sidekiq worker" do
    worker.is_a?(Sidekiq::Worker).must_equal true
  end

  describe "performing the update" do

    let(:id)   { Object.new }
    let(:user) { Object.new }

    let(:integration_request_id) { Object.new }

    describe "the user can be found" do

      before do
        HiveWebApi.stubs(:update)
        PullEmailFromHiveWorker.stubs(:perform_async)

        IntegrationRequest.stubs(:find).with(integration_request_id).returns Struct.new(:data).new( { 'id' => id } )
        Refinery::User.stubs(:where).with(hive_lead_id: id).returns [user]
      end

      it "should update the user through the hive web api" do
        HiveWebApi.expects(:update).with user

        worker.perform integration_request_id
      end

      it "should pull the email from the hive" do
        PullEmailFromHiveWorker.expects(:perform_async).with id
        worker.perform integration_request_id
      end

    end

    describe "the user cannot be found" do

      before do
        IntegrationRequest.stubs(:find).with(integration_request_id).returns Struct.new(:data).new( { 'id' => id } )
        Refinery::User.stubs(:where).with(hive_lead_id: id).returns []
      end

      it "should update the user through the hive web api" do
        HiveWebApi.expects(:update).never
        worker.perform integration_request_id
      end

      it "should pull the email from the hive" do
        PullEmailFromHiveWorker.expects(:perform_async).never
        worker.perform integration_request_id
      end

    end

  end

end
