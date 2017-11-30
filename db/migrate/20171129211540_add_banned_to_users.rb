class AddBannedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :banned, :boolean
  end
end
