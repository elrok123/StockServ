class Watchlist < ActiveRecord::Base
  belongs_to :favourite
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => :favourite_id
end