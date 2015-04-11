class AddUserToDelayedJobs < ActiveRecord::Migration
  def change
    add_reference :delayed_jobs, :user, index: true
  end
end
