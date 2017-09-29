class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :reviewer
      t.string :reviewee
      t.integer :service_id
      t.integer :rating
      t.text :description

      t.timestamps
    end
  end
end
