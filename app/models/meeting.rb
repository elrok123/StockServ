class Meeting < ActiveRecord::Base
    validates :meeting_subject, presence: true,
				length: { 
					  minimum: 2,
					  maximum: 20,
					  too_short: "Must be longer title"
					  too_long: "Title too long"
					}

    validates :date_of_meeting, presence: true, 
				  format: { with: ^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$,
				 message: "Date format incorrect. Enter in dd/mm/yyyy style"

    validates :client_name, presence: true,
			      length: {
					  minimum: 2,
                                          maximum: 20,
                                          too_short: "Name too short"
                                          too_long: "Name too long"
                                       }

    validates :meeting_description, length: { maximum: 1000 }
end
