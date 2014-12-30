WakeUpRails.load_all_ruby_files_in "#{`bundle show willow`.strip}/app"
WakeUpRails.load_all_ruby_files_in File.dirname(__FILE__) + '/../../app'
if ENV['CLIENT_SPECIFIC_GEM_NAME']
  WakeUpRails.load_all_ruby_files_in "#{`bundle show #{ENV['CLIENT_SPECIFIC_GEM_NAME']}`.strip}/app"
end
