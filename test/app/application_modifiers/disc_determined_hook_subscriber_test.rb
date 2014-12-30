require_relative '../../minitest_helper'

describe DiscDeterminedHookSubscriber do

  let(:subscriber) { DiscDeterminedHookSubscriber.new }

  it "should be a hook subscriber" do
    subscriber.is_a?(HookSubscriber).must_equal true
  end

  it "should respond to the complete event" do
    DiscDeterminedHookSubscriber.event.must_equal :complete
  end

  it "should respond to the Make DISC Assignment" do
    DiscDeterminedHookSubscriber.hook.must_equal 'Make DISC Assignment'
  end

  describe "finding the appropriate disc application" do

    [true, false].each do |help_is_wanted|

      describe "sample disc choices" do

        let(:letters) do
          ['i', 's', 'a', 'b'].sort_by { |x| random_string }
        end

        let(:sample_disc_choices) do
          {
            "disc_#{letters[0]}_choices" => "Testing᱗Enthusiastic᱗Optimistic᱗High-Spirited",
            "disc_#{letters[1]}_choices" => "Apple,Orange",
            "disc_#{letters[2]}_choices" => "Apple,Orange,",
            "disc_#{letters[3]}_choices" => "Banana\nKiwi",
          }
        end

        let(:lead) { { 'data' => {} } }

        let(:user) { Struct.new(:hive_lead_id).new Object.new }

        before do
          sample_disc_choices.each { |k, v| lead['data'][k] = v }
          HiveApi.stubs(:find_by_hive_lead_id).with(user.hive_lead_id).returns lead
          subscriber.stubs(:user).returns user
          HelpOrNotRules.stubs(:help_is_wanted?).with(lead).returns help_is_wanted
        end

        it "should return the one with the letter" do
          application = Object.new
          MasterApplication.stubs(:where).with(name: "Bryan #{help_is_wanted ? 'With Help' : 'No Help'} - #{letters[0].upcase}").returns [application]
          subscriber.disc_application.must_be_same_as application
        end
      end

      describe "no disc choices" do
        let(:letters) do
          ['i', 's', 'a', 'b'].sort_by { |x| random_string }
        end

        let(:sample_disc_choices) do
          {
          }
        end

        let(:lead) { { 'data' => {} } }

        let(:user) { Struct.new(:hive_lead_id).new Object.new }

        before do
          HiveApi.stubs(:find_by_hive_lead_id).with(user.hive_lead_id).returns lead
          subscriber.stubs(:user).returns user
          HelpOrNotRules.stubs(:help_is_wanted?).with(lead).returns help_is_wanted
        end

        it "should return the D one with the letter" do
          application = Object.new
          MasterApplication.stubs(:where).with(name: "Bryan #{help_is_wanted ? 'With Help' : 'No Help'} - D").returns [application]
          subscriber.disc_application.must_be_same_as application
        end
      end

    end

  end

  describe "go" do

    let(:user_application_id) { Object.new }
    let(:student_application) { Struct.new(:user_application_id).new user_application_id }
    let(:user_application)    { Struct.new(:application_stamp).new(user_application_stamp_data.to_json)   }
    let(:master_application)  { Struct.new(:application_stamp).new(master_application_stamp_data.to_json) }
    let(:user) do
      u = Refinery::User.new
      u.hive_lead_id = SecureRandom.uuid
      u
    end

    before do
      HiveApi.stubs(:update_lead_record_data)
      subscriber.stubs(:user).returns user
      subscriber.stubs(:application).returns student_application
      UserApplication.stubs(:find).with(user_application_id).returns user_application
    end

    describe "when the disc step is on both applications" do

      let(:user_application_stamp_data) do
        {
          id:          random_string,
          step_groups: [
                         { 
                           steps: [
                                    { random_string => random_string, tag: random_string },
                                    { random_string => random_string, tag: "#{random_string}Make DISC Assignment#{random_string}" },
                                    { random_string => random_string, tag: random_string },
                                  ]
                         },
                         { 
                           steps: [
                                    { random_string => random_string, tag: random_string },
                                    { random_string => random_string, tag: random_string },
                                  ]
                         },
                       ]
        }
      end

      let(:master_application_stamp_data) do
        {
          id:          random_string,
          step_groups: [
                         { 
                           steps: [
                                    { random_string => random_string },
                                    { random_string => random_string },
                                  ]
                         },
                         { 
                           steps: [
                                    { random_string => random_string },
                                    { random_string => random_string, tag: "#{random_string}Make DISC Assignment#{random_string}" },
                                    { random_string => random_string },
                                  ]
                         },
                       ]
        }
      end


      describe "if a disc application exists for this situation" do

        before { subscriber.stubs(:disc_application).returns master_application }

        describe "updating the user application with the application stamp of the matching DISC record" do

          it 'should set the disc_type in user data' do
            user_application.stubs(:versioned_save)
            subscriber.stubs(:the_matching_disc_letter).returns 'Z'

            HiveApi.expects(:update_lead_record_data).with do |lead_id, data|
              lead_id.must_equal user.hive_lead_id
              data.must_equal({ disc_type: 'Z' })
              true
            end

            subscriber.go
          end

          it "should save the disc application over the user application, EXCEPT FOR THE TAGGED STEP" do

            user_application.expects(:versioned_save).with do

              stamp = JSON.parse user_application.application_stamp

              # the first step group should have been copied over entirely from the disc application
              stamp['step_groups'][0].to_json.must_equal master_application_stamp_data[:step_groups][0].to_json

              # the second master application has a single step that will not match the disc application,
              # so I have to test these steps separately
              stamp['step_groups'][1]['steps'][0].to_json.must_equal master_application_stamp_data[:step_groups][1][:steps][0].to_json
              stamp['step_groups'][1]['steps'][2].to_json.must_equal master_application_stamp_data[:step_groups][1][:steps][2].to_json

              # note that the tagged disc step is replaced with the original tagged step from the user application
              stamp['step_groups'][1]['steps'][1].to_json.must_equal user_application_stamp_data[:step_groups][0][:steps][1].to_json

            end

            subscriber.go

          end

          it "should maintain the original user application id" do

            user_application.expects(:versioned_save).with do
              stamp = JSON.parse user_application.application_stamp
              stamp['id'].must_equal user_application_stamp_data[:id]
            end

            subscriber.go
              
          end

        end

      end

      describe "if a disc application DOES NOT exist for this situation" do

        before { subscriber.stubs(:disc_application).returns nil }

        it "should update the user application with the application stamp of the matching DISC record" do
          user_application.expects(:versioned_save).never
          subscriber.go
        end

      end

    end

    describe "when the the disc step is on the user application but not the master" do

      let(:user_application_stamp_data) do
        {
          step_groups: [
                         { 
                           steps: [
                                    { random_string => random_string, tag: random_string },
                                    { random_string => random_string, tag: "#{random_string}Make DISC Assignment#{random_string}" },
                                    { random_string => random_string, tag: random_string },
                                  ]
                         },
                         { 
                           steps: [
                                    { random_string => random_string, tag: random_string },
                                    { random_string => random_string, tag: random_string },
                                  ]
                         },
                       ]
        }
      end

      let(:master_application_stamp_data) do
        {
          step_groups: [
                         { 
                           steps: [
                                    { random_string => random_string },
                                    { random_string => random_string },
                                  ]
                         },
                         { 
                           steps: [
                                    { random_string => random_string },
                                    { random_string => random_string },
                                  ]
                         },
                       ]
        }
      end


      describe "if a disc application exists for this situation" do

        before { subscriber.stubs(:disc_application).returns master_application }

        describe "updating the user application with the application stamp of the matching DISC record" do

          it "should save the disc application over the user application" do

            user_application.expects(:versioned_save).with do

              stamp = JSON.parse user_application.application_stamp

              stamp['step_groups'][0].to_json.must_equal master_application_stamp_data[:step_groups][0].to_json
              stamp['step_groups'][1].to_json.must_equal master_application_stamp_data[:step_groups][1].to_json

            end

            subscriber.go

          end

        end

      end

      describe "if a disc application DOES NOT exist for this situation" do

        before { subscriber.stubs(:disc_application).returns nil }

        it "should update the user application with the application stamp of the matching DISC record" do
          user_application.expects(:versioned_save).never
          subscriber.go
        end

      end

    end

  end

end
