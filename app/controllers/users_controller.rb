class UsersController < ApplicationController
	def index
		if @user.access_level < 2
			redirect_to "/dashboard/show"
		end
		@users = User.all
	end
	def new
		if @user.access_level < 2
			redirect_to "/dashboard/show"
		end
		@user_entry = User.new()
	end
	def edit
		if @user.access_level < 2
			redirect_to "/dashboard/show"
		end
		@user_entry = User.find(params[:id])
	end
	def update
		@check_params = user_params
		@check_params.delete(:password) if user_params[:password].blank?
		if @user.access_level < 2
			redirect_to "/dashboard/show"
		end
		@user_entry = User.find(params[:id])
		if @user_entry.update(@check_params)
			redirect_to '/users'
		else
			render 'edit'
		end
	end
	def create
		if @user.access_level < 2
			redirect_to "/dashboard/show"
		end
		@user_entry = User.new(user_params)
		if @user_entry.save
			redirect_to users_path
		else
			render 'new'
		end
	end
	def destroy
		if @user.access_level < 2
			redirect_to "/dashboard/show"
		end
		@user_entry = User.find(params[:id])
		Client.destroy_all(:user_id=>params[:id])
		@user_entry.destroy
		redirect_to users_path			
	end
	private
	def user_params
		params.require(:user_entry).permit(:firstname, :surname, :email, :username, :password, :access_level)	
	end
	def edit_user_params
		params.require(:user_entry).permit(:firstname, :surname, :email, :username, :access_level)	
	end
end
