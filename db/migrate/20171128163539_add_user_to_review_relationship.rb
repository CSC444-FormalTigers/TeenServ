class AddUserToReviewRelationship < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :reviewer, :string
    remove_column :reviews, :reviewee, :string
    remove_column :reviews, :service_id, :integer
 
    add_column :reviews, :reviewer_id, :integer
    add_column :reviews, :reviewee_id, :integer
  end
end
