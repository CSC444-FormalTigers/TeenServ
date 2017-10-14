class CreateTeenagers < ActiveRecord::Migration[5.1]
  def change
    create_table :teenagers do |t|
      t.text :username
      t.integer :rating
      t.decimal :account_balance
      t.text :bank_key
      t.text :description
      t.text :resume

      t.timestamps
    end
  end
end
