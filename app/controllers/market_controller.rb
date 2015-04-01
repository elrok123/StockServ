class MarketController < ApplicationController
	def show
			@data = get_yhoo_hist_fin(company_tag)
			@comp_name = YahooFinance.quotes([@data[0].symbol.upcase], [:name])
			@high = Hash.new()
			@low = Hash.new()
			@open = Hash.new()
			@close = Hash.new()
			@close_a = Hash.new()
			@close_b = Hash.new()
			@info_array = Array.new()

			@data_a = get_yhoo_hist_fin(company_tag_a)
			@data_b = get_yhoo_hist_fin(company_tag_b)

			#Compile highs and lows tuples for graph
			@data.each do |e| 
				@high[e.trade_date] = e.high 
				@low[e.trade_date] = e.low 
				@open[e.trade_date] = e.open 
				@close[e.trade_date] = e.close 
			end

			@data_a.each do |e| 
				@close_a[e.trade_date] = e.close 
			end

			@data_b.each do |e| 
				@close_b[e.trade_date] = e.close 
			end

			@info_array = ["High", @high, "Low", @low, "Open", @open, "Close", @close]
			@i = -9.99 
			@info_array[1].map {|k, v| @i = v.gsub(/[^\d^\.]/, '').to_f unless @i > v.gsub(/[^\d^\.]/, '').to_f } 
			@highest = @high.max_by{|k,v| v}
			@info_array[3].map {|k, v| @i = v.gsub(/[^\d^\.]/, '').to_f unless @i < v.gsub(/[^\d^\.]/, '').to_f } 
			@lowest = @low.min_by{|k,v| v} 
			@comp_name_a = YahooFinance.quotes([company_tag_a], [:name])
			@comp_name_b = YahooFinance.quotes([company_tag_b], [:name])
			@data_a = get_yhoo_hist_fin(company_tag_a)
			@data_b = get_yhoo_hist_fin(company_tag_b)

			@info_array_compare = [company_tag_a, @close_a, company_tag_b, @close_b]
			if (@close_b.max_by{|k,v| v})[1] > (@close_a.max_by{|k,v| v})[1]
				@highest_compare = @close_b.max_by{|k,v| v}
				@lowest_compare = @close_a.max_by{|k,v| v}
			else
				@highest_compare = @close_a.max_by{|k,v| v}
				@lowest_compare = @close_b.max_by{|k,v| v}
			end
	end
	
	def company_tag
		if params.has_key?(:company_tag)
			params[:company_tag].upcase
		else
			"AAPL"
		end
	end

	def company_tag_a
		if params.has_key?(:company_tag_a)
			params[:company_tag_a].upcase
		else
			"AAPL"
		end
	end

	def company_tag_b
		if params.has_key?(:company_tag_b)
			params[:company_tag_b].upcase
		else
			"YHOO"
		end
	end
	def get_yhoo_hist_fin(company)
		begin
			quote = YahooFinance.historical_quotes(company, { start_date: 50.days.ago, end_date: Time::now})
			return quote
		rescue 
			return YahooFinance.historical_quotes("AAPL", { start_date: 50.days.ago, end_date: Time::now})
		end
	end
end