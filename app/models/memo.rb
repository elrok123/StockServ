class Memo < ActiveRecord::Base
    belongs_to: user
    validates :memo, presence: true, length: { minimum: 2, maximum: 100}
end
