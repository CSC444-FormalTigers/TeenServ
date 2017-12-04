class AddJobNameAndHoursWorkedToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :job_name, :string
    add_column :transactions, :HoursWorked, :integer
  end
end
