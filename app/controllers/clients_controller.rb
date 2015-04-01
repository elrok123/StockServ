class ClientsController < ApplicationController
	def index
		@clients = Client.where("user_id = ?", session[:user_id])
	end
	def show
		@client = Client.find_by_id(params[:id])
		if @client.nil? || @client.user_id != session[:user_id]
			#This can be replaced with a custom "permission denied" or "no such client" page
			render :file => "/app/views/errors/error404.erb"
		end	
	end
	def new
		@client = Client.new
	end
	def get_clients
		unless params[:client_name].nil?
			@clients = User.find(session[:user_id]).clients.where("first_name LIKE ? OR last_name LIKE ? OR (select concat(first_name, ' ', last_name)) LIKE ?", "%#{params[:client_name]}%", "%#{params[:client_name]}%", "%#{params[:client_name]}%")
			render json: @clients
		else
			render json: "{\"error\" : \"No user specified...\"}"
		end
	end
	def edit
		@client = Client.find(params[:id])
	end
	def update
		@client = Client.find(params[:id])
		if @client.update(client_params)
			redirect_to @client
		else
			render 'edit'
		end
	end
	def create
		@client = Client.new(client_params)
		@client.user_id = session[:user_id]
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
		params.require(:client).permit(:first_name, :last_name, :dob, :address, :home_tel, :mobile_tel, :email, :title, :user)	
	end
end
