require File.expand_path(File.dirname(__FILE__) + '/../../minitest_helper')

describe UpdateLeads360AndSendAccountActivationEmailWorker do

  let(:worker)    { UpdateLeads360AndSendAccountActivationEmailWorker.new }
  let(:lead_data) { Object.new }

  before do
    UpdateLeads360Worker.expects(:perform_async).with lead_data
    SendAccountActivationEmailWorker.expects(:perform_async).with lead_data

    worker.do_the_work lead_data
  end

  it "should send the activation email" do
    # expectation set above
  end

  it "should update leads360" do
    # expectation set above
  end

end
