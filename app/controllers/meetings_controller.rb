class MeetingsController < ApplicationController
    def show
    	
    	if User.find(session[:user_id]).meetings.count == 1
    		@meetings = User.find(session[:user_id]).meetings
    	else
    		@meetings = Array.new
	    	User.find(session[:user_id]).meetings.each do |meeting|
				@meetings << meeting
	    	end
    	end
    end

    def new
    	@clients = Client.where(user_id: session[:user_id]).order(:first_name, :last_name)

		@meeting = Meeting.new
    end

    def edit
        @meeting = Meeting.find(params[:id])
    end
    
    def create
		@meeting = Meeting.new(meeting_params)
		if @meeting.save
		    redirect_to '/meetings/show'
		else
		    redirect_to '/meetings/new'
		end
    end

    def update
		@meeting = Meeting.find(params[:id])

		if @meeting.update(meeting_params)
		    redirect_to @meeting
		else
		    render 'edit'
		end
    end

    def destroy
		@meeting = Meeting.find(params[:id])
		@meeting.destroy

		redirect_to meetings_path
    end

private

	def meeting_params
	    params.require(:meeting).permit(:meeting_subject, :meeting_date, :user_id, :client_id, :meeting_description)
	end
end
