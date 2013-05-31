require 'rake'
require 'net/http'
require 'rainbow'

namespace :ping do

  desc 'Ping all the domains on a provided list'
  task :all do
    uri = URI(ENV['URLS_LIST_URL'])

    begin
      res = Net::HTTP.get_response(uri)

      raise("#{ENV['URLS_LIST_URL']} invalid or unavailable") if res.code.to_i != 200

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
        Net::HTTP.start("#{app}.herokuapp.com") do |http|
          http.open_timeout = 2
          http.read_timeout = 2
          res = http.request_head('/')

          raise("#{app} respond with an error (#{res.code.to_i})") if res.code.to_i >= 400
        end
      rescue Timeout::Error => e
        print "ERROR: ".color(:red) + "#{app} timeout :(\n"
      rescue Exception => e
        print "ERROR: ".color(:red) + e.message + "\n"
        next
      end
    end
  end
end
