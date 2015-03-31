class Favourite < ActiveRecord::Base
	has_many :watchlists
  	has_many :users, through: :watchlists

  	validates_uniqueness_of :stock_symbol
end
