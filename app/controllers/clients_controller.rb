class ClientsController < ApplicationController
	def index
		@clients = Client.where("user_id = ?", session[:user_id])
		@users = User.all.order(:firstname, :surname)
		if @user.access_level > 1
			@clients = Client.all
		end
	end
	def show
		@client = Client.find_by_id(params[:id])
		@users = User.all.order(:firstname, :surname)
		if (@client.nil? || @client.user_id != session[:user_id]) && @user.access_level<2
			#This can be replaced with a custom "permission denied" or "no such client" page
			render :file => "/app/views/errors/error404.erb"
		end	
	end
	def new
		@users = User.all.order(:firstname, :surname)
		@client = Client.new
	end
	def get_clients
		unless params[:client_name].nil?
			#t = Client.arel_table
			#@clients = User.find(session[:user_id]).clients.where(t[:name].matches("%#{params[:client_name]}%"))
			@clients = User.find(session[:user_id]).clients.where("lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower((select concat(first_name, ' ', last_name))) LIKE ?", "%#{params[:client_name].downcase}%", "%#{params[:client_name].downcase}%", "%#{params[:client_name].downcase}%")
			render json: @clients
		else
			render json: "{\"error\" : \"No user specified...\"}"
		end
	end
	def edit
		@users = User.all.order(:firstname, :surname)
		@client = Client.find(params[:id])
	end
	def update
		@users = User.all.order(:firstname, :surname)
		@client = Client.find(params[:id])
		if @client.update(client_params)
			redirect_to @client
		else
			render 'edit'
		end
	end
	def create
		@users = User.all.order(:firstname, :surname)
		@client = Client.new(client_params)
		if params.has_key?(:user_id) 
		@client.user_id = session[:user_id]
		end
		if @client.save
			redirect_to @client
		else
			render 'new'
		end
	end
	def destroy
		@client = Client.find(params[:id])
		@client.user_id = nil
 		@client.save	
		redirect_to clients_path			
	end
	private
	def client_params
		params.require(:client).permit(:first_name, :last_name, :dob, :address, :home_tel, :mobile_tel, :email, :title, :user, :user_id)	
	end
end
