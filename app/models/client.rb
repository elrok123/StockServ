class Client < ActiveRecord::Base
    belongs_to :user
	validates :first_name, presence: true, length: {minumum: 1, maximum: 30}, format: {without: /[0-9]/}
	validates :last_name, presence: true, length: {minumum: 1, maximum: 30}, format: {without:/[0-9]/}
	validates :dob, presence: true
	validates :address, presence: true, length: {minimum: 3, maximum: 50}
	validates :email, presence: true, length: {minumum: 4, maximum: 30}, format: {with: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/}
	validates :home_tel, presence: true, length: {minimum: 10, maximum: 15}, numericality: :only_integer
        validates :mobile_tel, :allow_blank => true, length: {minimum: 10, maximum: 15}, numericality: :only_integer
	has_many :meetings
	def full_name
		self.first_name + " " + self.last_name
	end
end
