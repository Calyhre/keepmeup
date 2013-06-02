require './app'

module Clockwork
  every 5.minutes, 'App.ping_all' do
    App.ping_all
  end
end
