#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake/testtask'
require_relative `bundle show interchangeable`.strip + '/lib/interchangeable/rake.rb'

ConduitBryan::Application.load_tasks

Rake::Task[:default].prerequisites.clear
task :default => [:run_our_tests]

Rake::TestTask.new do |t|
  t.name = :run_our_tests
  t.libs.push "lib"
  t.test_files = FileList['test/app/*/*_test.rb',
                          'test/app/*_test.rb',
                          'test/app/*/*_spec.rb',
                          'test/app/*_spec.rb',
                          'pci/spec/app/*/*_test.rb',
                          'clientspecific/spec/app/*_test.rb',
                          'clientspecific/spec/app/*/*_spec.rb',
                          'clientspecific/spec/app/*_spec.rb']
  t.verbose = true
end

desc "get the students from stars" 
namespace :stars do

  desc "Records from STARS that need to be imported"
  task :count => :environment do
    client = StarsClient.new(username: ENV['STARS_USERNAME'], password: ENV['STARS_PASSWORD'])
    integration = StarsIntegration.new client
    p integration.students_to_import.count
  end

  desc "Import new records from STARS"
  task :import => :environment do
    client = StarsClient.new(username: ENV['STARS_USERNAME'], password: ENV['STARS_PASSWORD'])
    integration = StarsIntegration.new client
    integration.import_new_students_into_the_portal
  end

end

desc "Run the web request cleanup"
task :web_request_cleanup => :environment do
  WebRequest.cleanup
end

namespace :production do
  [:start, :stop].each do |method|

    desc "#{method} all services"
    task method do
      system "bundle exec ruby daemons/abandoned_step_analytics_daemon.rb #{method}"
      system "bundle exec ruby daemons/hive_email_to_refinery_sync_daemon.rb #{method}"
    end
  end
end

namespace :javascript do
  desc "Build everything"
  task :build do
    puts 'coffee --compile --bare lib/pdf/*.coffee'
    puts `coffee --compile --bare lib/pdf/*.coffee`
  end

  desc "Watch everything"
  task :watch do
    puts 'coffee --compile --bare --watch lib/pdf/*.coffee'
    puts `coffee --compile --bare --watch lib/pdf/*.coffee`
  end
end
