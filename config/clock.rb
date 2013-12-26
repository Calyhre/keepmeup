require_relative '../config/boot'
require_relative '../config/environment'

require "clockwork"

module Clockwork
  every 2.minutes, 'App.retrieve_from_heroku' do
    logs = App.retrieve_from_heroku
    puts "#{App.count} apps retrieved after #{ logs[:calls] } calls. #{ logs[:remaining] } calls remaining for an hour."
  end

  every 5.minutes, 'App.ping_apps' do
    App.ping_apps
  end
end
