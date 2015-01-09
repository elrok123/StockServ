class ApplicationController < ActionController::Base
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception
  	before_filter :check_authentication

  	def check_authentication
  		if params[:controller] != "sessions" && session[:user_id].nil?
  			redirect_to :root
  		else
  			get_set_user_details
  		end
  	end
  	def get_set_user_details
  		@user = User.find(session[:user_id])
  	end
end
