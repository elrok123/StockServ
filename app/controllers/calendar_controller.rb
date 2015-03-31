class CalendarController < ApplicationController
  	def show
  		if params[:start_date].nil?
  			@meetings = get_meetings_by_month
  		else
  			@meetings = get_meetings_by_month(params[:start_date])
  		end
  	end
private
    def get_meetings_by_month(start_date=nil)
		meetings ||= Hash.new()
		if start_date.nil?
			Meeting.where(meeting_date: Date.today.beginning_of_month.strftime..Date.today.end_of_month.strftime).each do |meeting|
				meetings[meeting.meeting_date.to_date.to_formatted_s(:db)] ||= Array.new()
				meetings[meeting.meeting_date.to_date.to_formatted_s(:db)] << [meeting.client_name, meeting.meeting_time]
			end
		else
			Meeting.where(meeting_date: start_date.to_date.beginning_of_month.strftime..start_date.to_date.end_of_month.strftime).each do |meeting|
				meetings[meeting.meeting_date.to_date.to_formatted_s(:db)] ||= Array.new()
				meetings[meeting.meeting_date.to_date.to_formatted_s(:db)] << [meeting.client_name, meeting.meeting_time]
			end
		end
		return meetings
	end
end
