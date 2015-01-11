class DashboardController < ApplicationController
	def show
		@data = YahooFinance.historical_quotes("GOOG", { start_date: 50.days.ago, end_date: Time::now})
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

		#Calculate highest and lowest stock figures to set min and max on the graph
		@i = -9999999.99 
		@info_array[1].map {|k, v| @i = v.gsub(/[^\d^\.]/, '').to_f unless @i > v.gsub(/[^\d^\.]/, '').to_f } 
		@highest = (@i + 50.0).round(-2) 
		@info_array[3].map {|k, v| @i = v.gsub(/[^\d^\.]/, '').to_f unless @i < v.gsub(/[^\d^\.]/, '').to_f } 
		@lowest = (@i - 50.0).round(-2) 
	end
end