# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
client1 = Meeting.create(:meeting_subject => "Stock Investment", :date_of_meeting => "24/05/2014", :client_name => "John Smith", :meeting_description => "We aim to discuss potential stock investments I have lined up")
