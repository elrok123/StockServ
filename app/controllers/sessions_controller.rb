class SessionsController < ApplicationController
  	def new
  		if !session[:user_id].nil?
  			redirect_to "/dashboard/show"
  		end
	end
	def create
		user = User.authenticate(user_params)
		if user
			session[:user_id] = user.id
			redirect_to "/dashboard/show", :notice => "Logged in!"
		else
			@error = "Invalid email or password"
			redirect_to :root, notice: "Failed to login"
		end
	end
	def destroy
		session[:user_id] = nil
		@user = nil
		reset_session
		redirect_to root_url, :notice => "Logged out!"
	end
	private
		def user_params
	      	params.require(:user).permit(:email, :password)
	    end
end
