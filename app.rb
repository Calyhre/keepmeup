require 'rubygems'
require 'compass'
require 'sinatra'
require 'redis'
require 'sidekiq'
require 'active_support/core_ext/numeric'
require 'clockwork'
require 'httparty'
require 'haml'

uri = URI.parse(ENV["REDISTOGO_URL"])
$redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)
$apps  = ENV['APP_LIST'].present? ? ENV['APP_LIST'].split(',') : []

class App < Sinatra::Application
  include Sidekiq::Worker

  set :app_file, __FILE__
  set :root, File.dirname(__FILE__)
  set :views, 'views'
  set :public_dir, 'public'

  configure do
    Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.rb'))
  end

  get '/' do
    @apps = []
    $apps.each do |app|
      @apps << { name: app, status: $redis.get("app_#{app}_status").to_i }
    end
    haml :index
  end

  get '/stylesheets/:name.css' do
    content_type 'text/css', charset: 'utf-8'
    sass(:"stylesheets/#{params[:name]}", Compass.sass_engine_options )
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

  def self.version
    '1.0.0'
  end
end
