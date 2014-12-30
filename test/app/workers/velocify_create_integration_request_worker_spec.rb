require File.expand_path(File.dirname(__FILE__) + '/../../minitest_helper')

describe VelocifyCreateIntegrationRequestWorker do

  let(:worker) { VelocifyCreateIntegrationRequestWorker.new }

  it "should be a sidekiq worker" do
    worker.is_a?(Sidekiq::Worker).must_equal true
  end

end

describe "building a request to create a user, in the old hive_mongodb way" do

  [['1234', {
              "first_name"         => 'a',
              "last_name"          => 'b',
              "email"              => 'c',
              "campus_of_interest" => 'd',
              "hive_lead_id"       => '1234'
           }],
   ['7890', {
              "first_name"         => 'a',
              "last_name"          => 'b',
              "email"              => 'c',
              "campus_of_interest" => 'd',
              "hive_lead_id"       => '7890'
           }]
  ].map { |x| Struct.new(:lead_id, :data).new(*x) }.each do |example|
    describe "multiple examples" do

      before do
        HiveApi.drop
        HiveApi.create_lead_record example.lead_id, example.data
      end

      it "should mold the data according to the old format (#{example.lead_id})" do
        lead = HiveApi.find_by_hive_lead_id(example.lead_id)
        result = VelocifyCreateIntegrationRequestWorker.build_the_old_create_request_from lead
        result['first_name'].must_equal example.data['first_name']
        result['last_name'].must_equal example.data['last_name']
        result['email'].must_equal example.data['email']
        result['campus_of_interest'].must_equal example.data['campus_of_interest']
        result['hive_lead_id'].must_equal example.lead_id
      end

      it "should mold the data according to the old format, as hashes too (#{example.lead_id})" do
        lead = HiveApi.find_by_hive_lead_id(example.lead_id)
        result = VelocifyCreateIntegrationRequestWorker.build_the_old_create_request_from lead
        result[:first_name].must_equal example.data['first_name']
        result[:last_name].must_equal example.data['last_name']
        result[:email].must_equal example.data['email']
        result[:campus_of_interest].must_equal example.data['campus_of_interest']
        result[:hive_client_id].must_equal 'pci'
        result[:hive_lead_id].must_equal example.lead_id
      end

    end

  end
  
  describe "performing the creation" do

    let(:integration_request_id) { Object.new }

    let(:worker) { VelocifyCreateIntegrationRequestWorker.new }

    let(:hive_lead_id) { Object.new }

    let(:request) { { 'hive_lead_id' => hive_lead_id } }
    let(:lead)    { Object.new }
    let(:lead_id) { Object.new }
    let(:lead)    { Object.new }

    let(:lead_finder) { Object.new }
    let(:converter)   { Object.new }

    let(:data) { Object.new }

    let(:user) { Object.new }

    let(:integration_request_data) { { 'id' => lead_id } }

    before do
      Leads360::LeadFinder.stubs(:new).returns lead_finder
      IntegrationRequest.stubs(:find).with(integration_request_id).returns Struct.new(:data).new(integration_request_data)
      lead_finder.stubs(:get_lead_by_id).with(lead_id).returns lead
      HiveApi.stubs(:find_by_hive_lead_id).with(lead_id).returns lead
      VelocifyCreateIntegrationRequestWorker.stubs(:build_the_old_create_request_from).with(lead).returns request

      Leads360ToHashConverter.stubs(:new).returns converter
      converter.stubs(:convert).with(lead).returns data

      HiveApi.stubs(:create_lead_record)
      #StudentCreator.stubs(:update_leads_360_and_send_account_activation_email)

      StudentCreator.stubs(:update_leads_360_and_send_the_account_activation_email)
    end

    describe "when a user does not exist by this lead id" do

      before do
        Refinery::User.stubs(:where).with(hive_lead_id: hive_lead_id).returns []
      end

      it "should create the user, update leads360, and send the activation email" do
        first_name, last_name = random_string, random_string
        request['first_name'] = first_name
        request['last_name']  = last_name
        message = "An account for #{first_name} #{last_name} was created via a post from Velocify."
        UserApi.expects(:create_user)
               .with(request, { message: message }).returns user
        StudentCreator.expects(:update_leads_360_and_send_the_account_activation_email)
                      .with(user)

        worker.perform integration_request_id
      end

    end

    describe "when a user exists by this lead id" do

      before do
        Refinery::User.stubs(:where).with(hive_lead_id: hive_lead_id).returns [Object.new]
      end

      it "should not take any actions" do
        UserApi.expects(:create_user).never
        StudentCreator.expects(:update_leads_360_and_send_the_account_activation_email).never

        worker.perform integration_request_id
      end

    end

    describe "exceptions occur" do

      describe "when a user api throws a record invalid exception trying to create the user" do

        before do
          Refinery::User.stubs(:where).with(hive_lead_id: hive_lead_id).returns []
          UserApi.stubs(:create_user).raises(ActiveRecord::RecordInvalid.new(Refinery::User.new))
        end

        it "should eat the error and not run the student creator" do
          StudentCreator.expects(:update_leads_360_and_send_the_account_activation_email).never

          worker.perform integration_request_id
        end

      end

      describe "when a student creator throws a record invalid exception" do

        let(:exception) { ActiveRecord::RecordInvalid.new(Refinery::User.new) }

        before do
          Refinery::User.stubs(:where).with(hive_lead_id: hive_lead_id).returns []
          UserApi.stubs(:create_user).returns Object.new
          StudentCreator.stubs(:update_leads_360_and_send_the_account_activation_email).raises(exception)
        end

        it "pass the error" do
          result = begin
                     worker.perform integration_request_id
                   rescue ActiveRecord::RecordInvalid => e
                     e
                   end
          result.must_be_same_as exception
        end

      end

      describe "when other errors are thrown" do
        before do
          Refinery::User.stubs(:where).with(hive_lead_id: hive_lead_id).returns []
          UserApi.stubs(:create_user).raises 'not an invalid error exception'
        end

        it "should not eat the error" do
          expected_error = Object.new
          error = begin
                    worker.perform integration_request_id
                  rescue
                    expected_error
                  end

          error.must_be_same_as expected_error
        end

      end

    end

  end

end
