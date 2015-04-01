class Share < ActiveRecord::Base
	has_many :owned_shares
	has_many :clients, through: :owned_shares
	validates_uniqueness_of :company_tag
end
