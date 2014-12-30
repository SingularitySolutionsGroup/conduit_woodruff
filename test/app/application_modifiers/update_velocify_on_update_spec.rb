require_relative '../../minitest_helper'

describe UpdateVelocifyOnUpdate do

  let(:subscriber) { UpdateVelocifyOnUpdate.new }

  it "should be a Hook Subscriber" do
    subscriber.is_a?(HookSubscriber).must_equal true
  end

  it "should respond to the complete event" do
    UpdateVelocifyOnUpdate.event.must_equal :complete
    subscriber.event.must_equal :complete
  end

  it "should respond to the 'Update Velocify Afterwards' hook/tag" do
    UpdateVelocifyOnUpdate.hook.must_equal "Update Velocify Afterwards"
    subscriber.hook.must_equal "Update Velocify Afterwards"
  end

  describe "go" do

    it "should update velocify with the user's lead data" do
      lead_data = Object.new
      user      = Struct.new(:hive_lead_id).new Object.new
      HiveApi.stubs(:find_by_hive_lead_id).with(user.hive_lead_id).returns lead_data
      subscriber.stubs(:user).returns user

      updater = Object.new
      Leads360Updater.stubs(:current).returns updater

      updater.expects(:update_lead).with lead_data

      subscriber.go
    end


  end

end
