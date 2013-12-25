class HerokuProcess < ActiveRecord::Base
  belongs_to :app, primary_key: 'name', foreign_key: 'app_name'
end
