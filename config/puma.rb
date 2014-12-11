threads ENV['PUMA_MIN_THREADS'] || 1, ENV['PUMA_MAX_THREADS'] || 2
workers 1
port ENV['PORT']

on_worker_boot do
  @clock_pid  ||= spawn 'bundle exec clockwork config/clock.rb'
end
