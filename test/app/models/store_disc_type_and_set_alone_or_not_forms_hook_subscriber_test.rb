require_relative '../../minitest_helper'

describe StoreDiscTypeAndSetAloneOrNotFormsHookSubscriber do

  describe 'go method' do

    describe 'setting the alone or together form ids' do

      it 'should set the form ids on the student application for any form with the Set Alone or Together Form tag' do
        expected_application_stamp = 'expected_application_stamp'
        modified_application = Object.new
        modified_application.stubs(:to_json).returns expected_application_stamp
        StoreDiscTypeAndSetAloneOrNotFormsHookSubscriber.
            stubs(:get_the_application_with_the_alone_or_together_forms_set).
            with(application, lead).
            returns modified_application

        subscriber.go

        UserApplication.find(user_application.id).application_stamp.must_equal expected_application_stamp
      end

      before do
        DiscDeterminedHookSubscriber.
            stubs(:disc_letter_for_lead).
            returns expected_disc_type
        HiveApi.stubs(:update_lead_record_data)
        subscriber.stubs(:application).returns application
      end

    end

    it 'should set the disc type in the lead data' do
      StoreDiscTypeAndSetAloneOrNotFormsHookSubscriber.stubs(:get_the_application_with_the_alone_or_together_forms_set).returns Object.new
      subscriber.stubs(:application).returns StudentApplication.new
      DiscDeterminedHookSubscriber.
          stubs(:disc_letter_for_lead).
          with(lead).
          returns expected_disc_type

      HiveApi.expects(:update_lead_record_data).with do |lead_id, lead_data|
        lead_id.must_equal user.hive_lead_id
        lead_data['disc_type'].must_equal expected_disc_type
        true
      end

      subscriber.go
    end

    before do
      subscriber.stubs(:user).returns user
      subscriber.instance_variable_set(:@user_application_id, user_application.id)
      UserApplication.stubs(:where).with({ id: user_application.id }).returns [user_application]
      HiveApi.stubs(:find_by_hive_lead_id).with(user.hive_lead_id).returns lead
    end

  end

  describe 'get_the_application_with_the_alone_or_together_forms_set method' do

    it 'should return the student application with the proper form ids set for online' do
      lead['data']['campus_of_interest'] = 'Online'
      disc_letter = 'Z'
      campus_or_online = 'Online'
      DiscDeterminedHookSubscriber.stubs(:disc_letter_for_lead).with(lead).returns disc_letter
      Form.stubs(:where).with do |query, args|
        query == 'tags ilike ?' &&
          args == "%Alone or Together #{campus_or_online} #{disc_letter}%"
      end.returns [expected_alone_together_form]

      result = StoreDiscTypeAndSetAloneOrNotFormsHookSubscriber.get_the_application_with_the_alone_or_together_forms_set application, lead

      [step2, step3].each do |s|
        result.steps.select{ |step| step.id == s.id }.first.form_id.must_equal expected_alone_together_form.id.to_s
      end
      [step3, step4].each do |s|
        result.steps.select{ |step| step.id == s.id }.first.form_id.must_equal s.form_id
      end
    end

    it 'should return the student application with the proper form ids set for campus' do
      lead['data']['campus_of_interest'] = 'Some ground campus name'
      disc_letter = 'Z'
      campus_or_online = 'Campus'
      DiscDeterminedHookSubscriber.stubs(:disc_letter_for_lead).with(lead).returns disc_letter
      Form.stubs(:where).with do |query, args|
        query == 'tags ilike ?' &&
          args == "%Alone or Together #{campus_or_online} #{disc_letter}%"
      end.returns [expected_alone_together_form]

      result = StoreDiscTypeAndSetAloneOrNotFormsHookSubscriber.get_the_application_with_the_alone_or_together_forms_set application, lead

      [step2, step3].each do |s|
        result.steps.select{ |step| step.id == s.id }.first.form_id.must_equal expected_alone_together_form.id.to_s
      end
      [step3, step4].each do |s|
        result.steps.select{ |step| step.id == s.id }.first.form_id.must_equal s.form_id
      end
    end

    before do
      Form.stubs(:where).returns []
    end

    let(:expected_alone_together_form) do
      f = Form.new
      f.id = rand(9999)
      f
    end

  end



  describe 'event method' do

    it 'should return Store DISC Type' do
      StoreDiscTypeAndSetAloneOrNotFormsHookSubscriber.event.must_equal :complete
    end

  end

  describe 'hook method' do

    it 'should return Store DISC Type' do
      StoreDiscTypeAndSetAloneOrNotFormsHookSubscriber.hook.must_equal 'Store DISC Type'
    end

  end

  let(:application) do
    a = StudentApplication.new
    a.user_application_id = user_application.id
    a.step_groups = [StepGroup.new, step_group]
    a
  end

  let(:user_application) do
    ua = UserApplication.new
    ua.user_id = user.id
    ua.id = rand(9999)
    ua
  end

  let(:step_group) do
    s = StepGroup.new
    s.steps = [step1, step2, step3, step4]
    s
  end

  let(:step1) do
    s = Step.new
    s.id = rand(9999)
    s.form_id = rand(9999)
    s
  end

  let(:step2) do
    s = Step.new
    s.id = rand(9999)
    s.form_id = rand(9999)
    s.tag = alone_or_together_tag
    s.stubs(:tags).returns ['z', alone_or_together_tag, 'z']
    s
  end

  let(:step3) do
    s = Step.new
    s.id = rand(9999)
    s.form_id = rand(9999)
    s.tag = alone_or_together_tag
    s.stubs(:tags).returns ['z', alone_or_together_tag, 'z']
    s
  end

  let(:step4) do
    s = Step.new
    s.id = rand(9999)
    s.form_id = rand(9999)
    s.tag = SecureRandom.uuid
    s
  end

  let(:alone_or_together_tag) do
    StoreDiscTypeAndSetAloneOrNotFormsHookSubscriber.alone_or_together_tag
  end

  let(:user) do
    u = Refinery::User.new
    u.hive_lead_id = SecureRandom.uuid
    u
  end

  let(:lead) do
    {
        'data' => {  }
    }
  end

  let(:expected_disc_type) { 'S' }

  let(:subscriber) do
    StoreDiscTypeAndSetAloneOrNotFormsHookSubscriber.new
  end

end
