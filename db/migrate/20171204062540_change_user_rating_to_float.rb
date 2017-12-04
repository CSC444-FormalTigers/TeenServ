class ChangeUserRatingToFloat < ActiveRecord::Migration[5.1]
  def self.up
    change_column :users, :rating, :float, :default => 0
  end
  def self.down
    change_column :users, :rating, :integer
  end
end
