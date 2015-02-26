Rails.application.routes.draw do
  engines = [Willow::Engine,
             (Object.const_defined?('Clientspecific') ? Clientspecific::Engine : nil)]
  engines.select { |x| x }.each { |e| mount e, at: '/' }
end
