class ClientsController < ApplicationController
	def index
		@clients = Client.all
	end
	def new
		@client = Client.new
	end
	def create
		@client = Client.new(params.require(:client).permit(:first_name, :last_name, :dob, :address, :home_tel, :mobile_tel, :email))
		if @client.save
			redirect_to @client
		else
			render 'new'
		end
	end
	def show
		@client = Client.find(params[:id])
	end
end
