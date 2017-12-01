class AddPaypalEmailToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :paypal_email, :string
  end
end
