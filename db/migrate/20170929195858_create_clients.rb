class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.text :username
      t.integer :rating
      t.decimal :account_balance
      t.text :bank_key
      t.text :description

      t.timestamps
    end
  end
end
