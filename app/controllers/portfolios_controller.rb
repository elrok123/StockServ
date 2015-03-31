class PortfoliosController < ApplicationController
	def show
		@client = Client.find(params[:id])
		if @client.user_id != session[:user_id]
			#Need a permission denied page, for now set it to new
			render 'new'
		end
			search_company
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
