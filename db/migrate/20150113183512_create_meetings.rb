class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :meeting_subject
      t.datetime :date_of_meeting
      t.string :client_name
      t.string :meeting_description
      t.timestamps null: false
    end
  end
end
