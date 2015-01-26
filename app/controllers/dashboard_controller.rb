class DashboardController < ApplicationController

	def show
		@data = get_yhoo_hist_fin

		@comp_name = YahooFinance.quotes([@data[0].symbol.upcase], [:name])
		@high = Hash.new()
		@low = Hash.new()
		@open = Hash.new()
		@info_array = Array.new()

		@calendar_switch = 1

		#Compile highs and lows tuples for graph
		@data.each do |e| 
			@high[e.trade_date] = e.high 
			@low[e.trade_date] = e.low 
			@open[e.trade_date] = e.open 
		end

		@info_array = ["High", @high, "Low", @low, "Open", @open]
		@i = -9999999.99 
		@info_array[1].map {|k, v| @i = v.gsub(/[^\d^\.]/, '').to_f unless @i > v.gsub(/[^\d^\.]/, '').to_f }
		@highest = (@i + 10.0)
		@info_array[3].map {|k, v| @i = v.gsub(/[^\d^\.]/, '').to_f unless @i < v.gsub(/[^\d^\.]/, '').to_f }
		@lowest = (@i - 10.0)

		@favourites_data = Array.new()
		#Compile highs and lows tuples for graph
		@data.each do |e| 
			@high[e.trade_date] = e.high 
			@low[e.trade_date] = e.low 
			@open[e.trade_date] = e.open 
		end 
		@info_array = ["High", @high, "Low", @low, "Open", @open]
		@i = -9999999.99 
		@info_array[1].map {|k, v| @i = v.gsub(/[^\d^\.]/, '').to_f unless @i > v.gsub(/[^\d^\.]/, '').to_f } 
		@highest = (@i + 50.0).round(-2) 
		@info_array[3].map {|k, v| @i = v.gsub(/[^\d^\.]/, '').to_f unless @i < v.gsub(/[^\d^\.]/, '').to_f } 
		@lowest = (@i - 50.0).round(-2)

		@favourites = User.find(session[:user_id]).favourites

		#User.find(session[:user_id]).favourites.each do |e, i|
		#	@favourites << Favourite.find(e)
		#end	

		@favourites_data = YahooFinance.quotes(@favourites.collect {|e| e.stock_symbol }, [:high, :name, :symbol, :low, :open])
		if params.has_key?(:stock_symbol) 
			delete_favourite
			redirect_to "/dashboard/show"
		end

		if params.has_key?(:favourite_tag) 
			add_favourite
			redirect_to "/dashboard/show"
		end

		if params.has_key?(:search_company_tag)
			search_company
		end

		if params.has_key?(:search_client_name)
			search_client
		end

	end
	
private
	def company_tag
		if params.has_key?(:company_tag)
			params[:company_tag].upcase
		else
			"GOOG"
		end
	end

	def get_yhoo_hist_fin
		begin
			quote = YahooFinance.historical_quotes(company_tag, { start_date: 50.days.ago, end_date: Time::now})
			return quote
		rescue 
			return YahooFinance.historical_quotes("GOOG", {start_date: 50.days.ago, end_date: Time::now})
		end
	end

	def get_favourite_symbol(symbol_stock)
		if params.has_key?(symbol_stock)
			params[symbol_stock].upcase
		end
	end

	def delete_favourite
		if User.find(session[:user_id]).favourites.delete(Favourite.find(get_favourite_symbol(:stock_symbol)).id)
			@success = "You have successfully removed that favourite"	
		end
	end

	def add_favourite
		#User.find(session[:user_id]).favourites << Favourite.new(stock_symbol: get_favourite_symbol(:favourite_tag))
		test_exist = Favourite.new(stock_symbol: get_favourite_symbol(:favourite_tag))
		if(test_exist.save)
			Watchlist.new(user_id: session[:user_id], favourite_id: test_exist.id).save
		else
			Watchlist.new(user_id: session[:user_id], favourite_id: Favourite.find_by(stock_symbol: get_favourite_symbol(:favourite_tag)).id).save
		end
	end

	def search_company
		@search_company_data = YahooFinance.quotes([params[:search_company_tag].upcase], [:high, :name, :symbol, :low, :open])
	end

	def search_client
		search_term = params[:search_client_name].downcase.split
		@search_client_data = Client.where("first_name='#{search_term.first.humanize}' OR last_name='#{search_term.last.humanize}'")
	end


end