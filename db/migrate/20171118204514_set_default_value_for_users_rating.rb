class SetDefaultValueForUsersRating < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :rating, :integer, :default => 0
  end
end
