class DashboardController < ApplicationController

	def show
		@data = get_yhoo_hist_fin
		@comp_name = YahooFinance.quotes([@data[0].symbol.upcase], [:name])
		@high = Hash.new()
		@low = Hash.new()
		@open = Hash.new()
		@info_array = Array.new()
		@calendar_switch = 1

		#Compile highs and lows tuples for graph
		@data.each do |e| 
			@high[e.trade_date] = e.high 
			@low[e.trade_date] = e.low 
			@open[e.trade_date] = e.open 
		end

		@info_array = ["High", @high, "Low", @low, "Open", @open]
		@i = -9999999.99 
		@info_array[1].map {|k, v| @i = v.gsub(/[^\d^\.]/, '').to_f unless @i > v.gsub(/[^\d^\.]/, '').to_f }
		@highest = (@i + 10.0)
		@info_array[3].map {|k, v| @i = v.gsub(/[^\d^\.]/, '').to_f unless @i < v.gsub(/[^\d^\.]/, '').to_f }
		@lowest = (@i - 10.0)
		@favourites_data = Array.new()
		@favourites = User.find(session[:user_id]).favourites

		@favourites_data = YahooFinance.quotes(@favourites.collect {|e| e.stock_symbol }, [:high, :name, :symbol, :low, :open])

		if params.has_key?(:stock_symbol) 
			delete_favourite
			redirect_to "/dashboard/show"
		end
		
		@calendar_switch = 1

		@meetings = get_meetings_by_week(params[:start_date])

		if params.has_key?(:favourite_tag) 
			add_favourite
			redirect_to "/dashboard/show"
		end

		if params.has_key?(:search_company_tag)
			search_company
		end

		if params.has_key?(:search_client_name)
			search_client
		end

		@info_array = ["High", @high, "Low", @low, "Open", @open]
		@i = -9999999.99 
		@info_array[1].map {|k, v| @i = v.gsub(/[^\d^\.]/, '').to_f unless @i > v.gsub(/[^\d^\.]/, '').to_f }
		@highest = (@i + 10.0)
		@info_array[3].map {|k, v| @i = v.gsub(/[^\d^\.]/, '').to_f unless @i < v.gsub(/[^\d^\.]/, '').to_f }
		@lowest = (@i - 10.0)
	end
private
	def company_tag
		if params.has_key?(:company_tag)
			params[:company_tag].upcase
		else
			"GOOG"
		end
	end

	def get_yhoo_hist_fin
		begin
			quote = YahooFinance.historical_quotes(company_tag, { start_date: 50.days.ago, end_date: Time::now})
			return quote
		rescue 
			return YahooFinance.historical_quotes("GOOG", {start_date: 50.days.ago, end_date: Time::now})
		end
	end

	def get_favourite_symbol(symbol_stock)
		if params.has_key?(symbol_stock)
			params[symbol_stock].upcase
		end
	end

	def delete_favourite
		if User.find(session[:user_id]).favourites.delete(Favourite.find(get_favourite_symbol(:stock_symbol)).id)
			@success = "You have successfully removed that favourite"	
		end
	end 

	def add_favourite
		#User.find(session[:user_id]).favourites << Favourite.new(stock_symbol: get_favourite_symbol(:favourite_tag))
		test_exist = Favourite.new(stock_symbol: get_favourite_symbol(:favourite_tag))
		if(test_exist.save)
			Watchlist.new(user_id: session[:user_id], favourite_id: test_exist.id).save
		else
			Watchlist.new(user_id: session[:user_id], favourite_id: Favourite.find_by(stock_symbol: get_favourite_symbol(:favourite_tag)).id).save
		end
	end

	def search_company
		@search_company_data = YahooFinance.quotes([params[:search_company_tag].upcase], [:high, :name, :symbol, :low, :open])
	end

	def search_client
		search_term = params[:client_name].downcase.split
		@search_client_data = Client.where("user_id = #{session[:user_id]} AND first_name='#{search_term.first.humanize}' OR user_id = #{session[:user_id]} AND last_name='#{search_term.last.humanize}'")
	end
	def get_meetings_by_week(start_date=nil)
		meetings ||= Hash.new()
		if start_date.nil?
			User.find(session[:user_id]).meetings.where(meeting_date: Date.today.beginning_of_week.strftime..Date.today.end_of_week.strftime).each do |meeting|
				meetings[meeting.meeting_date.to_date.to_formatted_s(:db)] ||= Array.new()
				meetings[meeting.meeting_date.to_date.to_formatted_s(:db)] << [Meeting.find(meeting.id).client.full_name, meeting.meeting_time]
			end
		else
			User.find(session[:user_id]).meetings.where(meeting_date: start_date.to_date.beginning_of_week.strftime..start_date.to_date.end_of_week.strftime).order(:meeting_date).each do |meeting|
				meetings[meeting.meeting_date.to_date.to_formatted_s(:db)] ||= Array.new()
				meetings[meeting.meeting_date.to_date.to_formatted_s(:db)] << [Meeting.find(meeting.id).client.full_name, meeting.meeting_time]
			end
		end
		return meetings
	end
end
