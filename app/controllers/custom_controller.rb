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

end
