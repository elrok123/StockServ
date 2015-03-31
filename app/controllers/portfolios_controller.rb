class PortfoliosController < ApplicationController
	def show
		@client = Client.find(params[:id])
		if @client.user_id != session[:user_id]
			#Need a permission denied page, for now set it to new
			render 'new'
		end
			search_company
	end
	def add
		@client = Client.find(params[:client_id])
		unless params[:funds].nil?
			@client.funds = @client.funds + params[:funds].to_f
			if @client.save
				redirect_to "/portfolios/" + params[:client_id].to_s
			else
				redirect_to "/portfolios/" + params[:client_id].to_s
			end
		else
			redirect_to "/portfolios/" + params[:client_id].to_s
		end
	end

	def company_tag
		if params.has_key?(:company_tag)
			params[:company_tag].upcase
		else
			#PUT STUFF IN HERE FOR RETREIVING CURRENTLY OWNED SHARES
			["GOOG"]
		end
	end

	def search_company
		@search_company_data = YahooFinance.quotes(company_tag, [:high, :name, :symbol, :low, :open])
	end
end
