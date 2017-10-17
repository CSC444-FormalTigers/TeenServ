class CreateEndorsements < ActiveRecord::Migration[5.1]
  def change
    create_table :endorsements do |t|
      t.string :endorser
      t.string :endorsee
      t.string :skill

      t.timestamps
    end
  end
end
