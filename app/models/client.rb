class Client < ActiveRecord::Base
	has_many :meetings
<<<<<<< .merge_file_ekEldx
    belongs_to :user
=======
    has_many :users, through: :meetings
>>>>>>> .merge_file_i9SQEx

    validates_uniqueness_of :last_name, :scope => [:first_name, :address], :message => ('implies that a client with these details already exists in the database')
	validates_uniqueness_of :email, :scope => [:first_name, :last_name], :message => ('implies that a client with these details already exists in the database')
	validates :first_name, presence: true, length: {minumum: 1, maximum: 30}
	validates :last_name, presence: true, length: {minumum: 1, maximum: 30}
	validates :dob, presence: true
	validates :address, presence: true
	validates :email, presence: true, length: {minumum: 4, maximum: 30}, format: {with: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/}
	validates :home_tel, presence: true, length: {minimum: 5}

	def full_name
		self.first_name + " " + self.last_name
	end
end
