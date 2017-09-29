class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :from_user
      t.string :to_user
      t.integer :service_id
      t.integer :amount

      t.timestamps
    end
  end
end
