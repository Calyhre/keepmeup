class HerokuProcess < ActiveRecord::Base
  belongs_to :app, primary_key: 'name', foreign_key: 'app_name', touch: true

  scope :dynos, -> { where("process LIKE 'web.%'") }
  scope :ups, -> { where("state = 'up'") }
  scope :asleep, -> { where("state = 'idle'") }
end
