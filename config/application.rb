require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Keepmeup
  class Application < Rails::Application

    if ENV['HTTP_AUTH']
      config.middleware.insert_after(::Rack::Runtime, "::Rack::Auth::Basic", "Staging") do |u, p|
        [u, p] == ENV['HTTP_AUTH'].split(':')
      end
    end
  end
end
