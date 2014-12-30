require File.expand_path(File.dirname(__FILE__) + '/../../minitest_helper')

describe "updating hive web api" do

  describe "the update method" do

    let(:user) { Struct.new(:hive_lead_id).new random_string }

    let(:lead_finder) { Object.new }

    before do
      Leads360::LeadFinder.stubs(:new).returns lead_finder
      lead_finder.stubs(:get_agent_by_id).returns nil
    end

    describe "and the lead can be found in leads 360" do

      let(:lead)           { Object.new }
      let(:converter)      { Object.new }
      let(:converted_data) { {} }

      before do
        lead_finder.stubs(:get_lead_by_id).with(user.hive_lead_id).returns lead
        Leads360ToHashConverter.stubs(:new).returns converter
        converter.stubs(:convert).with(lead).returns converted_data
      end

      it "should convert the data and update the local lead record" do
        HiveApi.expects(:update_lead_record_data).with user.hive_lead_id, converted_data
        HiveWebApi.update user
      end

      describe "there is an agent_name in the converted data, last name first" do

        let(:first_name) { random_string }
        let(:last_name)  { random_string }

        before do
          converted_data['agent_name'] = "#{last_name}, #{first_name}"
        end

        it "put the first name first, and the last name last" do
          HiveApi.expects(:update_lead_record_data).with do |hive_lead_id, data|
            data['agent_name'] == "#{first_name} #{last_name}"
          end
          HiveWebApi.update user
        end
      end

      describe "getting more agent information" do

        describe "the agent information can be found" do

          let(:agent) { Struct.new(:phone, :email).new random_string, random_string }

          let(:agent_id)    { Object.new }
          let(:agent_phone) { Object.new }

          before do
            lead_finder.stubs(:get_agent_by_id).with(agent_id).returns agent
            converted_data['agent_id'] = agent_id
          end

          it "should set the agent phone" do
            HiveApi.expects(:update_lead_record_data).with do |hive_lead_id, data|
              data['agent_phone'] == agent.phone
            end

            HiveWebApi.update user
          end

          it "should set the agent email" do
            HiveApi.expects(:update_lead_record_data).with do |hive_lead_id, data|
              data['agent_email'] == agent.email
            end

            HiveWebApi.update user
          end

        end

        describe "the agent information cannot be found" do

          it "should set the default phone number" do
            HiveApi.expects(:update_lead_record_data).with do |hive_lead_id, data|
              data['agent_phone'] == "417-862-0755"
            end

            HiveWebApi.update user
          end

        end

      end

    end

  end

end
