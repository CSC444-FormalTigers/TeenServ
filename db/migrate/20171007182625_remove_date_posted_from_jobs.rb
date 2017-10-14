class RemoveDatePostedFromJobs < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :date_posted, :datetime
  end
end
