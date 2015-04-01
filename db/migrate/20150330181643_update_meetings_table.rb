class UpdateMeetingsTable < ActiveRecord::Migration
  def change
  	change_table :meetings do |t|
  		t.belongs_to :user, index: true
  		t.belongs_to :client, index: true
  	end
  	remove_column :meetings, :client_name
  end
end
