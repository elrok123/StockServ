class MeetingsController < ApplicationController

    def index
         @meetings = Meeting.where("user_id = ?", session[:user_id])
         @meetings = @meetings.sort_by &:meeting_date
    end
    def show
        @meeting = Meeting.find_by_id(params[:id])
         if @meeting.nil? || @meeting.user_id != session[:user_id]
         #This can be replaced with a custom "permission denied" or "no such client" page
                 render :file => "/app/views/errors/error404.erb"
         end
    end

    def new
    	@clients = Client.where(user_id: session[:user_id]).order(:first_name, :last_name)

		@meeting = Meeting.new
    end

    def edit
        @clients = Client.where(user_id: session[:user_id]).order(:first_name, :last_name)
        @meeting = Meeting.find(params[:id])
    end
    
    def create
        @clients = Client.where(user_id: session[:user_id]).order(:first_name, :last_name)
		@meeting = Meeting.new(meeting_params)
		if @meeting.save
		    redirect_to '/meetings'
		else
		    redirect_to '/meetings/new'
		end
    end

    def update
        @clients = Client.where(user_id: session[:user_id]).order(:first_name, :last_name)
		@meeting = Meeting.find(params[:id])

		if @meeting.update(meeting_params)
		    redirect_to '/meetings'
		else
		    render 'edit'
		end
    end

    def destroy
		@meeting = Meeting.find(params[:id])
		@meeting.destroy

		redirect_to '/meetings'
    end

private

	def meeting_params
	    params.require(:meeting).permit(:meeting_subject, :meeting_date, :user_id, :client_id, :meeting_description).merge(user_id: session[:user_id])
	end
end
