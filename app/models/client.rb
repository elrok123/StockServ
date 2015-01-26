class Client < ActiveRecord::Base
        belongs_to :user
	validates :first_name, presence: true, length: {minumum: 1, maximum: 30}
	validates :last_name, presence: true, length: {minumum: 1, maximum: 30}
	validates :dob, presence: true
	validates :address, presence: true
	validates :email, presence: true, length: {minumum: 4, maximum: 30}, format: {with: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/}
	validates :home_tel, presence: true, length: {minimum: 5}
end
