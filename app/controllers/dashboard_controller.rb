class DashboardController < ApplicationController
	def show
		@data = get_yhoo_hist_fin
		#add_favourite
		#remove_favourite
		
		@comp_name = YahooFinance.quotes([@data[0].symbol.upcase], [:name])
		@high = Hash.new()
		@low = Hash.new()
		@open = Hash.new()
		@info_array = Array.new()
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
	end
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
			return YahooFinance.historical_quotes("GOOG", { start_date: 50.days.ago, end_date: Time::now})
		end
	end
	
	def get_favourite_symbol
		if params.has_key?(:stock_symbol)
			params[:stock_symbol].upcase
		end
	end
	def delete_favourite
		if Favourite.find(get_favourite_symbol).delete
			@success = "You have successfully added that favourite"	
		end
	end

	def remove_favourite
		if params.has_key?(:unfavourite_tag)
			new_favourite = params[:unfavourite_tag].upcase
			Favourite.find_by(stock_symbol: @new_favourite).destroy
		end
	end
end
