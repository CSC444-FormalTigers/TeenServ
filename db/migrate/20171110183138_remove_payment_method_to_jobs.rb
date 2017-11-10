class RemovePaymentMethodToJobs < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :payment_method, :string
  end
end
