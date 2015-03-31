class Meeting < ActiveRecord::Base
	belongs_to :user
	belongs_to :client

    validates :meeting_subject, presence: true,
				length: { 
					  minimum: 2,
					  maximum: 20,
					  too_short: "Must be longer title",
					  too_long: "Title too long"
					}

    validates :meeting_date ,presence: {message: "Date format incorrect. Enter in dd/mm/yyyy style"}
			#format: { with: /\A((((0[13578])|([13578])|(1[02]))[\/](([1-9])|([0-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\/](([1-9])|([0-2][0-9])|(30)))|((2|02)[\/](([1-9])|([0-2][0-9]))))[\/]\d{4}$|^\d{4}\z/}
	validates_uniqueness_of :meeting_date

	validates_presence_of :user_id

    validates :client_id, presence: true

    validates :meeting_description, length: { maximum: 1000 }
    def meeting_time
    	self.meeting_date.strftime("%I:%M%p")
    end
end