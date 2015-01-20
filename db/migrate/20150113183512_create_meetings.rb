class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :meeting_subject
      t.date :meeting_date
      t.time :meeting_time
      t.string :client_name
      t.text :meeting_description

      t.timestamps null: false
    end
  end
end
