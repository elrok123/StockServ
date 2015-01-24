class CreateAddClients < ActiveRecord::Migration
  def change
    create_table :add_clients do |t|

      t.timestamps null: false
    end
  end
end
