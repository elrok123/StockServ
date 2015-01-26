class Meeting < ActiveRecord::Base
<<<<<<< HEAD

    validates :meeting_subject, presence: true,	length: { minimum: 2, maximum: 20, too_short: "must be longer", too_long: "too long"}

    validates :client_name, presence: true, length: { minimum: 2, maximum: 20, too_short: "too short", too_long: "too long" }
=======
    validates :meeting_subject, presence: true,
				length: { 
					  minimum: 2,
					  maximum: 20,
					  too_short: "Must be longer title",
					  too_long: "Title too long"
					}

    validates :date_of_meeting, 
    			presence: {message: "Date format incorrect. Enter in dd/mm/yyyy style"}
				#format: { with: /\A((((0[13578])|([13578])|(1[02]))[\/](([1-9])|([0-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\/](([1-9])|([0-2][0-9])|(30)))|((2|02)[\/](([1-9])|([0-2][0-9]))))[\/]\d{4}$|^\d{4}\z/}
				

    validates :client_name, 
    			presence: true,
				length: {
				  minimum: 2,
				  maximum: 20,
				  too_short: "Title too short",
				  too_long: "Title too long"
				}
>>>>>>> master

    validates :meeting_description, length: { maximum: 1000 }

    validate :meeting_datetime_in_past

def meeting_datetime_in_past
   if meeting_date_time < Date.today or meeting_date_time < Time.now
          errors.add(:meeting_date_time, "can't be in the past")
  end
end

end
#
