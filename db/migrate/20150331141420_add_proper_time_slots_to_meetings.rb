class AddProperTimeSlotsToMeetings < ActiveRecord::Migration
  def change
  	remove_column :meetings, :meeting_date
  	change_table :meetings do |t|

  		t.column :meeting_date, :datetime, index: true, unique: true
  	end
  end
end