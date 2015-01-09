class DashboardController < ApplicationController
	def show
		@data = YahooFinance.historical_quotes("GOOG", { start_date: 180.days.ago, end_date: Time::now})
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

		line_chart (0..2).map {|e| 
			{ 
				name: @info_array[e*2], 
				data: @info_array[e*2+1]
			}
		}, 
		min:500, 
		colors:["#6600FF", "#FF0066", "#66CCFF"],
		library: 
			{
				backgroundColor: "#000006", 
				legend: 
					{
						textStyle:{color: "#dadada"}
					}
			}
	end
end