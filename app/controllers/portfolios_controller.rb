class PortfoliosController < ApplicationController
	#Functions for use in view
	helper_method :get_company_details

	def show
		@client = Client.find(params[:id])
		if @client.user_id != session[:user_id]
			#Need a permission denied page, for now set it to new
			render 'new'
		end
		@search_company_data = search_company
	end
	def add
		@client = Client.find(params[:client_id])

		if !params[:funds].nil?
			@client.funds = @client.funds + params[:funds].to_f
			if @client.save
				redirect_to "/portfolios/" + params[:client_id].to_s
			else
				redirect_to "/portfolios/" + params[:client_id].to_s
			end
		elsif !params[:company_tag].nil? && !params[:buy_shares].nil? && !params[:client_id].nil? && !params[:shares_quantity].nil?
			searched_company = search_company
			unless Share.exists?(company_tag: searched_company[0].symbol)
				new_share = Share.new(company_tag: searched_company[0].symbol)

				if new_share.save 
					if @client.funds >= params[:close_price].to_f
						if @client.shares.exists?(company_tag: params[:company_tag])
						share_detail = @client.shares.where(company_tag: params[:company_tag]).first.id
						new_client_share = @client.owned_shares.where(share_id: share_detail).first
						new_client_share.quantity = new_client_share.quantity + params[:shares_quantity].to_i
					else
						new_client_share = OwnedShare.new(share_id: Share.where(company_tag: searched_company[0].symbol).first.id, client_id: params[:client_id], close_price: params[:close_price], quantity: params[:shares_quantity])
					end
					if new_client_share.save
							@client.funds = @client.funds - (params[:close_price].to_f * params[:shares_quantity].to_f)
							if @client.save
								redirect_to "/portfolios/" + params[:client_id].to_s
							end
						else
							redirect_to "/portfolios/" + params[:client_id].to_s, :flash => { :error => "There was a problem saving your shares!" }
						end
					end
				else
					redirect_to "/portfolios/" + params[:client_id].to_s, :flash => { :error => "There was a problem saving your shares!" }
				end
			else
				if params[:close_price].to_f < @client.funds.to_f
					if @client.shares.exists?(company_tag: params[:company_tag])
						share_detail = @client.shares.where(company_tag: params[:company_tag]).first.id
						new_client_share = @client.owned_shares.where(share_id: share_detail).first
						new_client_share.quantity = new_client_share.quantity + params[:shares_quantity].to_i
					else
						new_client_share = OwnedShare.new(share_id: Share.where(company_tag: searched_company[0].symbol).first.id, client_id: params[:client_id], close_price: params[:close_price], quantity: params[:shares_quantity])
					end
					if new_client_share.save
						@client.funds = @client.funds - (params[:close_price].to_f * params[:shares_quantity].to_f)
						if @client.save
							redirect_to "/portfolios/" + params[:client_id].to_s
						end
					else
						redirect_to "/portfolios/" + params[:client_id].to_s, :flash => { :error => "There was a problem saving your shares!" }
					end
				else
					redirect_to "/portfolios/" + params[:client_id].to_s, :flash => { :error => "Insufficient funds!" }
				end
			end
		else
			redirect_to "/portfolios/" + params[:client_id].to_s
		end
	end
	def sell
		@client = Client.find(params[:client_id])
		if !params[:sell_quantity].nil? && !params[:owned_share_id].nil? && !params[:shares_quantity].nil? && !params[:sell_quantity].nil?
			
			company_details = get_company_details(@client.owned_shares.find(params[:owned_share_id].to_i).share.company_tag)
			@client.funds = @client.funds + (company_details[0].close.to_f * params[:shares_quantity].to_f)
			@client.owned_shares.find(params[:owned_share_id]).update(quantity: (@client.owned_shares.find(params[:owned_share_id]).quantity - params[:shares_quantity].to_i))
			if @client.save
				redirect_to "/portfolios/" + params[:client_id].to_s, flash: {success: "Successfully sold shares..."} 
			else
				redirect_to "/portfolios/" + params[:client_id].to_s, flash: {error: "Problem selling shares.. 1"}
			end
		elsif !params[:sell_all].nil? && !params[:owned_share_id].nil?
			company_details = get_company_details(@client.owned_shares.find(params[:owned_share_id].to_i).share.company_tag)
			quantity_to_sell = @client.owned_shares.find(params[:owned_share_id]).quantity
			@client.owned_shares.find(params[:owned_share_id]).destroy
			@client.funds = @client.funds + (company_details[0].close.to_f * quantity_to_sell.to_f)
			if @client.save
				redirect_to "/portfolios/" + params[:client_id].to_s, flash: {success: "Successfully sold shares..."} 
			else
				redirect_to "/portfolios/" + params[:client_id].to_s, flash: {error: "Problem selling shares.. 2"}
			end
		else
			redirect_to "/portfolios/" + params[:client_id].to_s, flash: {error: "Problem selling shares.. 3"}
		end
	end

	def company_tag
		if params.has_key?(:company_tag)
			[params[:company_tag].upcase]
		else
			#PUT STUFF IN HERE FOR RETREIVING CURRENTLY OWNED SHARES
			["GOOG"]
		end
	end

	def search_company
		YahooFinance.quotes(company_tag, [:high, :name, :symbol, :low, :open, :close])
	end
	def get_company_details(search_term="GOOG")
		YahooFinance.quotes([search_term.to_s.upcase], [:high, :name, :symbol, :low, :open, :close])
	end
end
