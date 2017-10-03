class RenameServicesToJobs < ActiveRecord::Migration[5.1]
  def self.up
    rename_table :services, :jobs
  end

  def self.down
    rename_table :services, :jobs
  end
end
