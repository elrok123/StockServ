class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :title
      t.text :text

      t.timestamps null: false
    end
  end
end
