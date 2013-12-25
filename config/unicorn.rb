require 'sidekiq'

worker_processes 3

before_fork do |server, worker|
  @worker_pid ||= spawn("bundle exec sidekiq -c 2")

  t = Thread.new {
    Process.wait(@worker_pid)
    puts "Worker died. Bouncing unicorn."
    Process.kill 'QUIT', Process.pid
  }
  # Just in case

  t.abort_on_exception = true

   @clock_pid   ||= spawn("bundle exec clockwork config/clock.rb")
end

after_fork do |server, worker|
  Sidekiq.configure_client do |config|
    config.redis = { size: 1 }
  end
  Sidekiq.configure_server do |config|
    config.redis = { size: 5 }
  end
end
