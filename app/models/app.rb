class App < ActiveRecord::Base
  include ActAsTimeAsBoolean

  APP_FIELDS = %w( dynos workers repo_size slug_size stack requested_stack create_status repo_migrate_status owner_delinquent owner_email owner_name web_url git_url buildpack_provided_description tier region )

  PROCESS_FIELDS = %w( pretty_state process state command elapsed transitioned_at release action size )

  has_many :processes, primary_key: 'name', foreign_key: 'app_name', class_name: HerokuProcess, dependent: :destroy

  time_as_boolean :ping_disabled, opposite: :ping_enabled

  scope :not_in_maintenance, -> { where( maintenance: false ) }
  scope :in_maintenance, -> { where( maintenance: true ) }
  scope :pingable, -> { ping_enabled.not_in_maintenance }

  def self.retrieve_from_heroku
    heroku_calls = 0

    he = Heroku::API.new

    request = he.get_apps
    heroku_apps = request.body
    heroku_calls += 1

    heroku_apps.map do |heroku_app|
      app = App.find_or_create_by name: heroku_app['name']
      app.update_attributes prepare_heroku_app(heroku_app)

      request = he.get_ps(app.name)
      heroku_processes = request.body
      heroku_calls += 1

      app.processes = heroku_processes.map do |heroku_process|
        process = HerokuProcess.find_or_create_by heroku_id: heroku_process['id']
        process.update_attributes prepare_heroku_process(heroku_process)

        process
      end

      request = he.get_app_maintenance(app.name)
      maintenance = request.body['maintenance']
      heroku_calls += 1

      app.update_attribute :maintenance, maintenance
      app
    end

    { calls: heroku_calls, remaining: request.headers['X-RateLimit-Remaining'] }
  end

  def self.ping_apps
    self.pingable.map do |app|
      begin
        res = HTTParty.head app.web_url, { timeout: 30 }
        res.code
      rescue Timeout::Error => e
        # TODO
      rescue Exception => e
        # TODO
      end
    end
  end

  private

  def self.prepare_heroku_app(app)
    app.reject{ |k, v| not k.in? APP_FIELDS }
  end

  def self.prepare_heroku_process(process)
    process.reject{ |k, v| not k.in? PROCESS_FIELDS }
  end
end
