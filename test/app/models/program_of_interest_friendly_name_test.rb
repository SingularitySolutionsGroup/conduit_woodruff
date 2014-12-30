require File.expand_path(File.dirname(__FILE__) + '/../../minitest_helper')

describe Refinery::User do

  describe 'the user has a program of interest that matches an item in the program_of_interest collection' do

    it 'should set the friendly name value to the friendly name value from the collection' do
      CollectionApi.
          stubs(:items_for_collection_tagged).
          with('program_of_interest').
          returns program_of_interest_collection_items

      data = user.get_user_profile_view_data

      data[:program_of_interest_friendly_name].must_equal program_of_interest_friendly_name
    end

  end

  describe 'the user has a program of interest that does not have a match in the programs collection' do

    it 'should set friendly_name to the program_of_interest the user has' do
      data = user.get_user_profile_view_data

      data[:program_of_interest_friendly_name].must_equal program_of_interest
    end

    before do
      CollectionApi.stubs(:items_for_collection_tagged).with('program_of_interest').returns []
    end

  end

  describe 'the lead is not found' do

    it 'should return an empty string' do
      HiveApi.stubs(:find_by_hive_lead_id).returns nil
      CollectionApi.
        stubs(:items_for_collection_tagged).
        with('program_of_interest').
        returns program_of_interest_collection_items

      data = user.get_user_profile_view_data

      data[:program_of_interest_friendly_name].must_equal nil
    end


  end

  before do
    HiveApi.stubs(:find_by_hive_lead_id).with(user.hive_lead_id).returns lead
  end

  let(:program_of_interest_collection_items) do
    [
        collection_item_1
    ]
  end

  let(:collection_item_1) do
    i = CollectionItem.new
    i.name = program_of_interest
    i.data['friendly_name'] = program_of_interest_friendly_name
    i
  end

  let(:user) do
    u = Refinery::User.new
    u.hive_lead_id = SecureRandom.uuid
    u.email        = "user#{rand(9999)}@test.net"
    u
  end

  let(:lead) do
    {
        'data' => {
                    'program_of_interest' => program_of_interest
                  }
    }
  end

  let(:program_of_interest) { 'something' }

  let(:program_of_interest_friendly_name) { 'something more friendly' }

end
