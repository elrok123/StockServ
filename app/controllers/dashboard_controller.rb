class DashboardController < ApplicationController
	def show
		@data = YahooFinance.historical_quotes("GOOG", { start_date: 20.days.ago, end_date: Time::now})
		@high = Hash.new()
		@low = Hash.new()
		@open = Hash.new()
		@info_array = Array.new()

		@data.each do |e| 
			@high[e.trade_date] = e.high 
			@low[e.trade_date] = e.low 
			@open[e.trade_date] = e.open 
		end 

		@info_array = ["High", @high, "Low", @low, "Open", @open]
		
	end
end