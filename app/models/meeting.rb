class Meeting < ActiveRecord::Base
    validates :meeting_subject, presence: true,
				length: { 
					  minimum: 2,
					  maximum: 20,
					  too_short: "Must be longer title",
					  too_long: "Title too long"
					}

    validates :client_name, presence: true,
			      length: {
					  minimum: 2,
                                          maximum: 20,
                                          too_short: "Name too short",
                                          too_long: "Name too long"
                                       }

    validates :meeting_description, length: { maximum: 1000 }
end
