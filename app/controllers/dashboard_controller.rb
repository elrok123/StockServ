class DashboardController < ApplicationController
	def show
		@data = YahooFinance.historical_quotes("GOOG", { start_date: 20.days.ago, end_date: Time::now})
		@high = Hash.new()
		@low = Hash.new()
		@open = Hash.new()
		@info_array = Array.new()
		@highest
		@lowest
	end
end