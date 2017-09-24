class CreateChangelogs < ActiveRecord::Migration[5.1]
  def change
    create_table :changelogs do |t|
      t.datetime :timestamp
      t.text :change
      t.string :username

      t.timestamps
    end
  end
end
