require_relative '../config/boot'
require_relative '../config/environment'

require "clockwork"

module Clockwork
  every 30.minutes, 'Retrieve apps' do
    App.retrieve_from_heroku
  end

  every 10.minutes, 'Retrieve processes' do
    App.retrieve_process_from_heroku
  end

  every 10.minutes, 'Ping apps' do
    App.ping_apps
  end
end
