class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :Users, :string
    add_column :users, :firstname, :string
    add_column :users, :surname, :string
  end
end
