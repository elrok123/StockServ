class User < ActiveRecord::Base

	has_many :watchlists
  	has_many :favourites, through: :watchlists
  	has_many :appointments
  	has_many :meetings
  	has_many :clients

	#Accessor for password
	attr_accessor :password

	#Methods to be executed before saving 
	validates :password, :presence => true,
	:confirmation => true
	before_save :encrypt_password
	validates_presence_of :firstname
	validates_presence_of :surname
	validates_presence_of :email
	validates_uniqueness_of :email
	has_many :clients

	def self.authenticate(details)
		user = find_by_email(details[:email])
		if user && user.password_hash == BCrypt::Engine.hash_secret(details[:password], user.password_salt)
			user
		else
			nil
		end
	end

	def fullname
		self.firstname + " " + self.surname
	end

private
	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end
end
