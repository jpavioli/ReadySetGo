class Competition < ApplicationRecord

    has_many :teams
    has_many :events

    # #validations
    validates :name, presence: true
    validates :description, length: { minimum: 10 }
    validates :description, presence: true
    validates :competition_manager_id, presence: true

end
