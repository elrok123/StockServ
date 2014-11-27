class DashboardController < ApplicationController
	def show
		@data = YahooFinance.historical_quotes("GOOG")
	end
end