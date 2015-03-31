class MeetingsController < ApplicationController

    def index
        @meetings = Meeting.where("user_id = ?", session[:user_id])
    end
    def show
        @meeting = Meeting.find_by_id(params[:id])
         if @meeting.nil? || @meeting.user_id != session[:user_id]
         #This can be replaced with a custom "permission denied" or "no such client" page
                 render :file => "/app/views/errors/error404.erb"
         end
    end

    def new
    	@clients = Client.all

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
	    params.require(:meeting).permit(:meeting_subject, :meeting_date, :client_name, :meeting_description).merge(user_id: session[:user_id])
	end

end
