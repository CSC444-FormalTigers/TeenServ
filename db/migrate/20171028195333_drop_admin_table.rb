class DropAdminTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :admins
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
