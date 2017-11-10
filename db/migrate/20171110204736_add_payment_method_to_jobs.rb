class AddPaymentMethodToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :payment_method, :string
  end
end
