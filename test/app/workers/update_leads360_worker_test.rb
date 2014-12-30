require File.expand_path(File.dirname(__FILE__) + '/../../minitest_helper')

describe UpdateLeads360Worker do
  let(:worker) { UpdateLeads360Worker.new }
  let(:updater) { mock }
  let(:lead_data) {
                    {
                        'first_name' => 'sam',
                        'email' => 'sam@test.com',
                        'hive_lead_id' => '12345',
                        'student_portal_id' => '1',
                        'student_portal_username' => 'joe',
                        'account_activation_id' => SecureRandom.uuid,
                        'campus_of_interest' => 'SKC-Distance Ed',
                    }
                  }
  let(:account_activation_url) {"#{ENV['STUDENT_PORTAL_URL']}activate-account?account_activation_id=#{lead_data['account_activation_id']}"}

  before do
    Leads360Updater.stubs(:current).returns(updater)
  end

  describe 'when the hive lead id does not exist' do

    it "should not error and not call the leads360 update" do

      current = Object.new
      Leads360Updater.stubs(:current).returns current

      current.expects(:update_lead).never

      worker = UpdateLeads360Worker.new
      worker.do_the_work({})
    end

  end

  describe 'when the hive lead id exists' do
    describe 'lead is valid but email is missing' do

      it 'should should update leads360' do
        data = lead_data.clone
        data.delete 'email'
        updater.expects(:update_lead).once

        worker.do_the_work data
      end
    end

    describe 'lead is valid and should receive account activation email' do
      before do
        Leads360Updater.stubs(:current).returns(updater)
        updater.stubs(:update_lead)
        Refinery::User.delete_all
        Refinery::User.create!({
                                  username: lead_data['student_portal_username'],
                                  email: lead_data['email'],
                                  hive_lead_id: lead_data['hive_lead_id'],
                                  password: 'test'
                              })
      end

      it 'should update leads 360' do
        updater.expects(:update_lead).with({
                                            lead_id: lead_data['hive_lead_id'],
                                            data: {
                                                     lead_id: lead_data['hive_lead_id'],
                                                     student_portal_id: lead_data['student_portal_id'],
                                                     student_portal_username: lead_data['student_portal_username'],
                                                     student_portal_account_activation_url: account_activation_url
                                                  }
                                           })

        worker.do_the_work lead_data
      end

      it 'should not fire the account activation email' do
        AccountActivationEmailSender
          .expects(:send)
          .never

        worker.do_the_work lead_data
      end
    end

    describe 'lead is valid and should not receive the account activation email' do
      ['North Kansas City', 'Lawrence', 'SKC-Distance Ed', 'South Kansas City', 'LAW-Distance Ed'].each do |campus_of_interest|
        it 'should not send the email' do
          updater.stubs(:update_lead)
          data = lead_data.clone
          data['campus_of_interest'] = campus_of_interest
          AccountActivationEmailSender.expects(:send).never

          worker.do_the_work data
        end
      end
    end

    [{
        #'first_name' => 'sam',
        'email' => 'sam@test.com',
        'hive_lead_id' => '12345',
        'student_portal_id' => '1',
        'student_portal_username' => 'joe',
        'account_activation_id' => SecureRandom.uuid,
        'campus_of_interest' => 'SKC-Distance Ed',
      },
      {
        'first_name' => 'sam',
        #'email' => 'sam@test.com',
        'hive_lead_id' => '12345',
        'student_portal_id' => '1',
        'student_portal_username' => 'joe',
        'account_activation_id' => SecureRandom.uuid,
        'campus_of_interest' => 'SKC-Distance Ed',
      },
      {
        'first_name' => 'sam',
        'email' => 'sam@test.com',
        #'hive_lead_id' => '12345',
        'student_portal_id' => '1',
        'student_portal_username' => 'joe',
        'account_activation_id' => SecureRandom.uuid,
        'campus_of_interest' => 'SKC-Distance Ed',
      },
      {
        'first_name' => 'sam',
        'email' => 'sam@test.com',
        'hive_lead_id' => '12345',
        #'student_portal_id' => '1',
        'student_portal_username' => 'joe',
        'account_activation_id' => SecureRandom.uuid,
        'campus_of_interest' => 'SKC-Distance Ed',
      },
      {
        'first_name' => 'sam',
        'email' => 'sam@test.com',
        'hive_lead_id' => '12345',
        'student_portal_id' => '1',
        #'student_portal_username' => 'joe',
        'account_activation_id' => SecureRandom.uuid,
        'campus_of_interest' => 'SKC-Distance Ed',
      },
      {
        'first_name' => 'sam',
        'email' => 'sam@test.com',
        'hive_lead_id' => '12345',
        'student_portal_id' => '1',
        'student_portal_username' => 'joe',
        #'account_activation_id' => SecureRandom.uuid,
        'campus_of_interest' => 'SKC-Distance Ed',
      },
      {
        'first_name' => 'sam',
        'email' => 'sam@test.com',
        'hive_lead_id' => '12345',
        'student_portal_id' => '1',
        'student_portal_username' => 'joe',
        'account_activation_id' => SecureRandom.uuid,
        #'campus_of_interest' => 'SKC-Distance Ed',
      },
    ].each do |data|
      describe 'lead data is invalid' do
        it 'should not fire the email' do
          updater.stubs(:update_lead)
          AccountActivationEmailSender.expects(:send).never

          worker.do_the_work data
        end
      end
    end
  end
end

class AccountActivationEmailSenderThatTracksCallCount
  class << self
    attr_accessor :count
    @count = 0
  end
  def self.send data = nil
    @count = @count + 1
  end
end

class UpdaterThatFails
  def self.update_lead data = nil
    raise 'the leads 360 update failed'
  end
end
