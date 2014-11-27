class DashboardController < ApplicationController
	def show
		@data = yahooFinance.get_quotes(YahooFinance::StandardQuote, 'yhoo')
	end
end
