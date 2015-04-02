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
			User.find(session[:user_id]).meetings.where(meeting_date: DateTime.now.beginning_of_month.strftime..DateTime.now.end_of_month.strftime).each do |meeting|
				meetings[meeting.meeting_date.to_date.to_formatted_s(:db)] ||= Array.new()
				meetings[meeting.meeting_date.to_date.to_formatted_s(:db)] << [("/meetings/" + meeting.id.to_s + "/edit"), Meeting.find(meeting.id).client.full_name, meeting.meeting_time]
			end
		else
			User.find(session[:user_id]).meetings.where(meeting_date: DateTime.parse(start_date.to_s).beginning_of_month.strftime..DateTime.parse(start_date.to_s).end_of_month.strftime).each do |meeting|
				meetings[meeting.meeting_date.to_date.to_formatted_s(:db)] ||= Array.new()
				meetings[meeting.meeting_date.to_date.to_formatted_s(:db)] << [("/meetings/" + meeting.id.to_s + "/edit"), Meeting.find(meeting.id).client.full_name, meeting.meeting_time]
			end
		end
		return meetings
	end
end
