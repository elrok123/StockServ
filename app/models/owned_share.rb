class OwnedShare < ActiveRecord::Base
	has_one :share
	belongs_to :client
	belongs_to :share
end
