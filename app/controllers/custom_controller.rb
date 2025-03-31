class CustomController < ApplicationController

  def programs
    items   = CollectionApi.items_for_collection_tagged('program_of_interest')
    options = items.select{ |i| i.data['program_area'].present? }.
                    reject{ |i| i.data['hide_from_application'].present? }.
                    select{ |i| (parse(i.data['program_area']) || {})['id'] == (params['program_area'] || {})['id'] }
    log 'retrieve programs', options
    render json: { options: options }
  end

  def start_dates
    items   = CollectionApi.items_for_collection_tagged('start_date')
    options = items.select{ |i| i.data['program_of_interest'].present? }.
                    select{ |i| (parse(i.data['program_of_interest']) || {})['id'] == (params['program_of_interest'] || {})['id'] }
    log 'retrieve start dates', options
    render json: { options: options }
  end

  def log action, data
    user_id = current_refinery_user ? current_refinery_user.id : 0
    Analytic.new.tap do |a|
      a.user_action = action
      a.user_id     = user_id
      a.create_date = DateTime.now
      a.user_agent  = request.user_agent
      a.status      = {
                        params: params,
                        data:   data
                      }.to_json
      a.save!
    end
  end

  def parse json
    JSON.parse json
  rescue
    {}
  end



end
