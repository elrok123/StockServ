class Meeting < ActiveRecord::Base

    validates :meeting_subject, presence: true,	length: { minimum: 2, maximum: 20, too_short: "must be longer", too_long: "too long"}

    validates :client_name, presence: true, length: { minimum: 2, maximum: 20, too_short: "too short", too_long: "too long" }

    validates :meeting_description, length: { maximum: 1000 }

    validate :meeting_datetime_in_past

def meeting_datetime_in_past
   if meeting_date_time < Date.today or meeting_date_time < Time.now
          errors.add(:meeting_date_time, "can't be in the past")
  end
end

end
