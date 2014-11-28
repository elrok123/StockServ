class DashboardController < ApplicationController
	def show
		@data = YahooFinance.historical_quotes(["GOOG"], { start_date: Time::now-(24*60*60*10), end_date: Time::now })
	end
end