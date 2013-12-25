require_relative '../config/boot'
require_relative '../config/environment'

require "clockwork"

module Clockwork
  every 20.seconds, 'Retrieving app from heroku' do
  end

  every 5.minutes, 'Ping all enabled apps' do
  end
end
