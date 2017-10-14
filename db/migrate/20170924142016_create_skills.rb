class CreateSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :skills do |t|
      t.string :username
      t.string :skill
      t.integer :proficiency

      t.timestamps
    end
  end
end
