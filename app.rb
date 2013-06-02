require 'rubygems'
require 'sinatra'
require 'redis'
require 'sidekiq'
require 'active_support/core_ext/numeric'
require 'clockwork'
require 'httparty'
require 'haml'

$redis = Redis.connect
$apps  = ENV['APP_LIST'].present? ? ENV['APP_LIST'].split(',') : []

class App < Sinatra::Application
  include Sidekiq::Worker

  get '/' do
    @apps = []
    $apps.each do |app|
      @apps << { name: app, status: $redis.get("app_#{app}_status") }
    end
    haml :index
  end

  def self.ping_all
    if $apps.any?
      $apps.each do |app|
        begin
          res = HTTParty.get("http://#{app}.herokuapp.com/")
          $redis.set("app_#{app}_status", res.code.to_i)
        rescue Timeout::Error => e
          $redis.set("app_#{app}_status", 0)
        rescue Exception => e
          $redis.set("app_#{app}_status", 0)
        end
      end
    else
      p 'APP_LIST is empty, did you missed it ?'
    end
  end

  def self.new(*)
    if ENV['AUTH_USER'].present? && ENV['AUTH_PASSWD'].present?
      app = Rack::Auth::Digest::MD5.new(super) do |username|
        {ENV['AUTH_USER'] => ENV['AUTH_PASSWD']}[username]
      end
      app.realm = 'Protected Area'
      app.opaque = 'secretkey'
      return app
    elsif ENV['FORCE_NON_SECURE'].present?
      p '/!\ Non secure enabled ! Anonymous have access to your apps status !!'
      return super
    else
      p 'You forget to provide a user AND a password.'
      sleep 30
      return exit
    end
  end
end
