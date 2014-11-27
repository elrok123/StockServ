class DashboardController < ApplicationController
	def show
		@data = YahooFinance.get_quotes(YahooFinance::StandardQuote, 'yhoo')
	end
end
