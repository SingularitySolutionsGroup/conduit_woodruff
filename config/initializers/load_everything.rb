WakeUpRails.load_all_ruby_files_in "#{`bundle show willow`.strip}/app"
WakeUpRails.load_all_ruby_files_in File.dirname(__FILE__) + '/../../app'
#WakeUpRails.load_all_ruby_files_in File.dirname(__FILE__) + '/../../clientspecific/app'
