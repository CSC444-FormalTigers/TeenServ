class MakeJobsAssociatedWithUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :jobs, :user, index: true
    add_foreign_key :jobs, :users
  end
end
