class MeetingsController < ApplicationController
    
  def index
    @meetings = Meeting.all
  end
 
  def show
    @meeting = Meeting.find(params[:id])
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
      redirect_to @meeting
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
      params.require(:meeting).permit(:meeting_subject, :meeting_date, :meeting_time, :client_name, :meeting_description)
    end
end
