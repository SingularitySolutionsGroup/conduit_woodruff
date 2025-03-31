
Rails.application.routes.draw do
  engines = [Willow::Engine,
             (Object.const_defined?('Clientspecific') ? Clientspecific::Engine : nil)]
  engines.select { |x| x }.each { |e| mount e, at: '/' }

  # LeadEntry.setup_routing(self, '/leadentry', { match: 'name of the lead entry form' } )
  WalkIn.setup_routing(self,    '/self-service',    { match: 'Self-Service' } )

  match '/custom/start-dates'         => 'custom#start_dates', via: [:post]
  match '/custom/programs'            => 'custom#programs', via: [:post]
  
end
