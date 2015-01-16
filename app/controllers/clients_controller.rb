class ClientsController < ApplicationController
	def new
	end
	def create
		@client = Client.new(params.require(:client).permit(:first_name, :last_name, :dob, :address, :home_tel, :mobile_tel, :email))
		@client.save
		redirect_to @client
	end
	def show
		@client = Client.find(params[:id])
	end
end
