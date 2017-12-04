class AddPaymentStatusToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :payment_status, :string
    add_column :transactions, :string, :string
  end
end
