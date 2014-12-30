Rails.application.routes.draw do
  match '/velocify/create' => 'integration_request#velocify_create', via: [:post, :get]
  match '/velocify/update' => 'integration_request#velocify_update', via: [:post, :get]
  match '/display_unsigned_form/:authentication_token/:lead_id/:form_id' => 'unsigned_form#display_form_with_user_data', via: [:post, :get]
  match '/get_unsigned_form/:authentication_token'                       => 'unsigned_form#get_unsigned_form', via: [:post, :get]
  match '/generate_award_letter'                                         => 'unsigned_form#generate_award_letter', :via => [:post]
  match '/get_program_data'                                              => 'financial_aid#get_program_data', :via => [:post]
  match '/students/update_fa_data'                                       => 'financial_aid#update_fa_data', :via => [:post]
  match '/students/toggle_student_block'                                 => 'financial_aid#toggle_student_block', :via => [:post]
  match '/students/get_student_block'                                    => 'financial_aid#get_student_block', :via => [:post]
  match '/get_license_key'                                               => 'student_overview#get_license_key', :via => [:post]
  match '/set_license_key'                                               => 'student_overview#set_license_key', :via => [:post]
  engines = [Willow::Engine,
             (Object.const_defined?('Clientspecific') ? Clientspecific::Engine : nil)]

  engines.select { |x| x }.each { |e| mount e, at: '/' }

  match '/set_student_presentation_url'     => 'screen_sharing#set_student_presentation_url', :via => [:post]
  match '/get_rep_presentation_url'         => 'screen_sharing#get_rep_presentation_url', :via => [:post]
end
