class DashboardController < ApplicationController
	def show
		@data = YahooFinance.quotes(["GOOG"], [:ask, :bid, :last_trade_date, :close, :dividend_per_share])
	end
end