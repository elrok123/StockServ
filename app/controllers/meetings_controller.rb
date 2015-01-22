class MeetingsController < ApplicationController

    def show
    	@meetings = Array.new
    	unless Meeting.count > 1
    		@meetings << Meeting.all.limit(1)
    	else
	    	Meeting.all.each do |meeting|
				@meetings << meeting
	    	end
    	end
    end

    def new
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
		    render 'new'
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
	    params.require(:meeting).permit(:meeting_subject, :date_of_meeting, :client_name, :meeting_description)
	end

end
