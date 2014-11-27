class DashboardController < ApplicationController
	def show
		data = YahooFinance.quotes(["BVSP", "NATU3.SA", "USDJPY=X"], [:ask, :bid, :last_trade_date])
	end
end
