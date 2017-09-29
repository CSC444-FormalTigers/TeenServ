class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :username
      t.string :title
      t.text :description
      t.datetime :date_posted
      t.boolean :reocurring
      t.datetime :work_date
      t.datetime :response_deadline
      t.integer :hourly_pay

      t.timestamps
    end
  end
end
