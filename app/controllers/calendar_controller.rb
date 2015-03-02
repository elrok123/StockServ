class CalendarController < ApplicationController
  	def show
  		@meetings = get_meetings_by_month

  	end
private
    def get_meetings_by_month
		meetings ||= Hash.new()
		Meeting.where(meeting_date: Date.today.beginning_of_month.strftime..Date.today.end_of_month.strftime).each do |meeting|
			meetings[meeting.meeting_date.to_date.to_formatted_s(:db)] ||= Array.new()
			meetings[meeting.meeting_date.to_date.to_formatted_s(:db)] << [meeting.client_name, meeting.meeting_time]
		end
		return meetings
	end
end
