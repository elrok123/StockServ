class Meeting < ActiveRecord::Base

    validates :meeting_subject, presence: true,	length: { minimum: 2, maximum: 20, too_short: "must be longer", too_long: "too long"}

    validates :client_name, presence: true, length: { minimum: 2, maximum: 20, too_short: "too short", too_long: "too long" }

    validates :meeting_description, length: { maximum: 1000 }


    validate :meeting_time_cannot_be_in_the_past

    def meeting_time_cannot_be_in_the_past

       if meeting_date == Date.today && meeting_time < Time.now
          errors.add(:meeting_time, "can't be in the past")
       end
    end

    validate :meeting_date_cannot_be_in_the_past
 
    def meeting_date_cannot_be_in_the_past

       if !meeting_date.blank? &&  meeting_date < Date.today
	  errors.add(:meeting_date, "can't be in the past")
       end
    end
end
