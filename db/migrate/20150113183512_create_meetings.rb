class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :meeting_subject
      t.datetime :meeting_date
      t.string :client_name
      t.text :meeting_description

      t.timestamps null: false
    end
  end
end
