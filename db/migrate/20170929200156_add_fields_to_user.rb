class AddFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :age, :integer
    add_column :users, :gender, :text
    add_column :users, :cell_phone, :text
    add_column :users, :home_phone, :text
    add_column :users, :name, :text
    add_column :users, :address, :text
    add_column :users, :photo, :text
    add_column :users, :account_type, :text
  end
end
