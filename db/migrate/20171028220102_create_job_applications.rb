class CreateJobApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :job_applications do |t|
      t.string :applicant_username
      t.references :job, foreign_key: true

      t.timestamps
    end
  end
end
