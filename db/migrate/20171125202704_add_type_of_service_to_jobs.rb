class AddTypeOfServiceToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :type_of_service, :string
  end
end
