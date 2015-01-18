class DashboardController < ApplicationController
	def show
			@data = get_yhoo_hist_fin
			@comp_name = YahooFinance.quotes([@data[0].symbol.upcase], [:name])
			@high = Hash.new()
			@low = Hash.new()
			@open = Hash.new()
			@info_array = Array.new()

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
end
