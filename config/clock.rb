require './app'

module Clockwork
  every 10.seconds, 'App.ping_all' do
    App.ping_all
  end
end
