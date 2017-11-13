class DropClientsTable < ActiveRecord::Migration[5.1]
  def change
    if ActiveRecord::Base.connection.table_exists? :clients
      drop_table :clients
    end
  end
end
