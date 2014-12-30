Refinery::User.class_eval do

  alias :old_get_user_profile_view_data :get_user_profile_view_data

  def get_user_profile_view_data
    data = old_get_user_profile_view_data
    data[:program_of_interest_friendly_name] = data[:program_of_interest]
    lead = HiveApi.find_by_hive_lead_id self.hive_lead_id
    return data unless lead
    program_collection_items = CollectionApi.items_for_collection_tagged 'program_of_interest'
    matching_collection_item = program_collection_items.select{ |collection_item| collection_item.name == lead['data']['program_of_interest'] }.first
    return data unless matching_collection_item
    data[:program_of_interest_friendly_name] = matching_collection_item.data['friendly_name']
    data
  end

end
