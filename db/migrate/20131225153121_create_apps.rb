class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|

      t.string    :name
      t.integer   :dynos
      t.integer   :workers
      t.integer   :repo_size
      t.integer   :slug_size
      t.string    :stack
      t.string    :requested_stack
      t.string    :create_status
      t.string    :repo_migrate_status
      t.boolean   :owner_delinquent
      t.string    :owner_email
      t.string    :owner_name
      t.string    :web_url
      t.string    :git_url
      t.string    :buildpack_provided_description
      t.string    :tier
      t.string    :region

      t.boolean   :maintenance
      t.datetime  :ping_disabled_at

      t.timestamps
    end

    add_index :apps, :name
  end
end
