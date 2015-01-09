class DashboardController < ApplicationController
	def show
		@data = YahooFinance.historical_quotes("GOOG", { start_date: 10.days.ago, end_date: Time::now })
		@main_data = Array.new()
	end
end