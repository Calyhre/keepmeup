class CreateHerokuProcesses < ActiveRecord::Migration
  def change
    create_table :heroku_processes do |t|

      t.string    :heroku_id
      t.string    :app_name
      t.string    :pretty_state
      t.string    :heroku_type
      t.string    :process
      t.string    :state
      t.string    :command
      t.integer   :elapsed
      t.datetime  :transitioned_at
      t.integer   :release
      t.string    :action
      t.integer   :size

      t.timestamps
    end

    add_index :heroku_processes, :heroku_id
  end
end
