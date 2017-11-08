class AddIsAcceptedToJobAndJobApplication < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :is_accepting_applicants, :boolean, default: true

    add_column :job_applications, :is_accepted, :boolean, default: false
  end
end
