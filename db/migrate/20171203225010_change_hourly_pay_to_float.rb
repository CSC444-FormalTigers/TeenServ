class ChangeHourlyPayToFloat < ActiveRecord::Migration[5.1]
  def change
    change_column :jobs, :hourly_pay, :float
  end
end
