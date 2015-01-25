class RemoveColumnFromUsers < ActiveRecord::Migration
  def change
	remove_column :users, :Users
  end
end
