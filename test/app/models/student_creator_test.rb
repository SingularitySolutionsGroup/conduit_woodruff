require File.expand_path(File.dirname(__FILE__) + '/../../minitest_helper')

describe StudentCreator do
  before do
    Refinery::User.delete_all
    HiveWebApi.stubs(:update)
  end

  [:first_name, :last_name, :email, :hive_client_id, :lead_id].to_objects {[
    ['John', 'Galt', 'test@test.com', 'client id', 'lead id']
  ]}.each do |test|
    describe "create method" do
      let(:expected_account_activation_id){ 'expected account activation id' }
      let(:expected_external_id){ 'expected external id' }
      let(:user_data){
                        {
                          first_name: test.first_name,
                          last_name: test.last_name,
                          email: test.email.upcase,
                          hive_client_id: test.hive_client_id,
                          hive_lead_id: test.lead_id
                        }
                     }
      let(:campus_of_interest){'SKC-Distance Ed'}

      describe "new user that does not exist" do

        describe "a record that is in the hive" do

          let(:now) { Time.now }

          before do
            Refinery::User.delete_all
            PasswordGenerator.expects(:generate).returns('test')

            UpdateLeads360AndSendAccountActivationEmailWorker.stubs(:perform_async)

            Timecop.freeze now
          end

          after do
            Timecop.return
          end

          it "should create a refinery user" do
            StudentCreator.create_user_update_leads360_and_send_activation_email user_data

            Refinery::User.count.must_equal 1
          end

          it 'should set the account_activation_id and external_id of the newly created refinery user' do
            SecureRandom.stubs(:uuid).returns(expected_account_activation_id).then.returns expected_external_id

            StudentCreator.create_user_update_leads360_and_send_activation_email user_data

            user = Refinery::User.first
            user.account_activation_id.must_equal expected_account_activation_id
            user.account_activation_id_stamp_date.to_i.must_equal now.to_i
            user.external_id.must_equal expected_external_id
          end

          it "should fire a job to update the users information from velocify" do
            HiveWebApiWorker.expects(:perform_async).with do |hash|
              hash['user_id'] == Refinery::User.first.id
            end
              
            StudentCreator.create_user_update_leads360_and_send_activation_email user_data
          end

          it "should set the appropriate values" do
            StudentCreator.create_user_update_leads360_and_send_activation_email user_data

            Refinery::User.first.contrast_with!({ first_name: test.first_name,
                                                last_name: test.last_name,
                                                email: test.email,
                                                hive_client_id: test.hive_client_id,
                                                hive_lead_id: test.lead_id })
          end

          it 'should set the master_application_id to StudentApplication.default_application_id' do
            StudentCreator.create_user_update_leads360_and_send_activation_email user_data

            new_user = Refinery::User.first
            new_user.master_application_id.must_equal StudentApplication.default_application_id
          end

          it 'should call UpdateLeads360AndSendAccountActivationEmailWorker.perform_async with new student data' do
            new_user = Refinery::User.new
            new_user.first_name = test.first_name
            new_user.email = test.email
            new_user.id = 2
            new_user.username = test.email
            new_user.hive_lead_id = test.lead_id
            new_user.account_activation_id = expected_account_activation_id
            Refinery::User.stubs(:create).returns(new_user)

            UpdateLeads360AndSendAccountActivationEmailWorker
              .expects(:perform_async)
              .with({
                      'first_name' => test.first_name,
                      'email' => test.email,
                      'hive_lead_id' => test.lead_id,
                      'student_portal_id' => new_user.id,
                      'student_portal_username' => test.email,
                      'account_activation_id' => expected_account_activation_id,
                    })
              .once

            StudentCreator.create_user_update_leads360_and_send_activation_email user_data
          end
        end

        describe "user email already exists" do
          [
            ["matches by email",   test.email,       "something else #{test.lead_id}"],
            ["matches by lead id", "x" + test.email, test.lead_id],
          ].map { |x| Struct.new(:name, :email, :lead_id).new(*x) }.each do |scenario|
            describe scenario.name do
              let(:expected_account_activation_id){'ewqewqewq'}
              before do
                Refinery::User.delete_all

                Refinery::User.create!(username: test.email,
                                      password: 'test',
                                      email: scenario.email,
                                      first_name: 'something else',
                                      last_name: 'something else',
                                      account_activation_id: expected_account_activation_id,
                                      hive_lead_id: scenario.lead_id)

                UpdateLeads360AndSendAccountActivationEmailWorker.stubs(:perform_async)
              end

              it "should not create an additional refinery user" do
                StudentCreator.create_user_update_leads360_and_send_activation_email user_data

                Refinery::User.count.must_equal 1
              end

              it 'should not update the account activation_id' do
                StudentCreator.create_user_update_leads360_and_send_activation_email user_data

                Refinery::User.first.account_activation_id.must_equal expected_account_activation_id
              end

              it 'should set the external_id of it is not set' do
                SecureRandom.stubs(:uuid).returns expected_external_id
                user = Refinery::User.first
                user.external_id = nil
                user.save!

                StudentCreator.create_user_update_leads360_and_send_activation_email user_data

                Refinery::User.first.external_id.must_equal expected_external_id
              end

              it 'should not set the external_id if it is already set' do
                SecureRandom.stubs(:uuid).returns '1234567890'
                user = Refinery::User.first
                user.external_id = expected_external_id
                user.save!

                StudentCreator.create_user_update_leads360_and_send_activation_email user_data

                Refinery::User.first.external_id.must_equal expected_external_id
              end

              it 'should set the is_account_activated property to false' do
                StudentCreator.create_user_update_leads360_and_send_activation_email user_data

                Refinery::User.first.is_account_activated.must_equal false
              end
            end

          end

        end

        describe "bad request" do
          before do
            Refinery::User.delete_all
            UpdateLeads360AndSendAccountActivationEmailWorker.stubs(:perform_async)
          end

          it "should not create a refinery user when hive_lead_id is missing" do
            StudentCreator.create_user_update_leads360_and_send_activation_email({
                                                                                  first_name: test.first_name,
                                                                                  last_name: test.last_name,
                                                                                  email: test.email,
                                                                                  hive_client_id: test.hive_client_id
                                                                                 })

            Refinery::User.count.must_equal 0
          end
        end
      end
    end

    describe 'user email is not provided 1' do
      let(:expected_account_activation_id) {'oijoijooijo'}
      let(:lead_id) {'lead_id'}
      before do
        SecureRandom.stubs(:uuid).returns('0987654321')
        Refinery::User.delete_all
        PasswordGenerator.stubs(:generate).returns('test')
        UpdateLeads360AndSendAccountActivationEmailWorker.stubs(:perform_async)
      end

      it 'should set username to be first letter of first name, first 4 of lastname, and some random digits' do
        StudentCreator.create_user_update_leads360_and_send_activation_email({
                                                                              first_name: 'first_name',
                                                                              last_name: 'LAST_name',
                                                                              hive_client_id: 'hive_client_id',
                                                                              hive_lead_id: lead_id
                                                                             })

        Refinery::User.last.username.must_equal 'flast0987'
        Refinery::User.last.email.must_equal 'flast0987@infinitefortress.com'
      end

      describe "first name is missing too" do
        it 'should set username to be first letter of first name, first 4 of lastname, and some random digits' do
          StudentCreator.create_user_update_leads360_and_send_activation_email({
                                                                                first_name: nil,
                                                                                last_name: 'LAST_name',
                                                                                hive_client_id: 'hive_client_id',
                                                                                hive_lead_id: lead_id
                                                                               })

          Refinery::User.last.username.must_equal 'last0987'
          Refinery::User.last.email.must_equal 'last0987@infinitefortress.com'
        end
      end

      describe "last name is missing too" do
        it 'should set username to be first letter of first name, first 4 of lastname, and some random digits' do
          StudentCreator.create_user_update_leads360_and_send_activation_email({
                                                                                first_name: 'first name',
                                                                                last_name: nil,
                                                                                hive_client_id: 'hive_client_id',
                                                                                hive_lead_id: lead_id
                                                                               })

          Refinery::User.last.username.must_equal 'f0987'
          Refinery::User.last.email.must_equal 'f0987@infinitefortress.com'
        end
      end
    end

    [nil, ''].each do |invalid_email|
      describe 'user email is not provided 2' do
        let(:expected_account_activation_id) {SecureRandom.uuid}
        let(:lead_id){'lead_id'}
        before do
          Refinery::User.delete_all
          PasswordGenerator.stubs(:generate).returns('test')
        end

        it 'should find a unique username when the first generated username is taken' do
          ['zyxwvutsrq', '987654321', 'expected'].each {|s| SecureRandom.stubs(:uuid).returns(s) }

          UpdateLeads360AndSendAccountActivationEmailWorker.stubs(:perform_async)
          Refinery::User.create(username: 'flastzyxw',
                              email: "someone@infinitefortress.com",
                              password: 'test',
                              first_name: 'first name',
                              last_name: 'last name',
                              hive_lead_id: 'abc',
                              hive_client_id: 'def',
                              account_activation_id: 'ghi')
          Refinery::User.create(username: 'flast9876',
                              email: "someone2@infinitefortress.com",
                              password: 'test',
                              first_name: 'first name',
                              last_name: 'last name',
                              hive_lead_id: 'abc',
                              hive_client_id: 'def',
                              account_activation_id: 'ghi')

          StudentCreator.create_user_update_leads360_and_send_activation_email({
                                                                                first_name: 'first_name',
                                                                                last_name: 'last_name',
                                                                                email: invalid_email,
                                                                                hive_client_id: 'hive_client_id',
                                                                                hive_lead_id: lead_id
                                                                               })

          Refinery::User.count.must_equal 3
          Refinery::User.last.username.must_equal 'flastexpe'
        end
      end
    end
  end
end
