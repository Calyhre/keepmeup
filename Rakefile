require 'rake'
require 'net/http'
require 'rainbow'
require 'httparty'

namespace :ping do

  desc 'Ping all the domains on a provided list'
  task :all do

    begin
      res = HTTParty.get(ENV['URLS_LIST_URL'])

      raise("#{ENV['URLS_LIST_URL']} invalid or unavailable (#{res.code.to_i})") if res.code.to_i != 200

      @list = []
      res.body.lines.each do |line|
        @list << line.strip
      end
    rescue Exception => e
      print "ERROR: ".color(:red) + e.message + "\n"
      next
    end

    @list.each do |app|
      begin
        res = HTTParty.get("http://#{app}.herokuapp.com/")
        raise("#{app} respond with an error (#{res.code.to_i})") if res.code.to_i >= 400
      rescue Timeout::Error => e
        print "ERROR: ".color(:red) + "#{app} timeout :(\n"
      rescue Exception => e
        print "ERROR: ".color(:red) + e.message + "\n"
        next
      end
    end
  end
end
