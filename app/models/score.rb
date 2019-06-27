class Score < ApplicationRecord

  #associations
  belongs_to :team
  belongs_to :event

  # #validations
  validates :score, numericality: { greater_than: 0 }
  validates :score, presence: true
  validates :team_id, presence: true
  validates :event_id, presence: true

  #methods
  def seconds_to_min(seconds)
    #converts seconds to minutes
    Time.at(seconds).utc.strftime("%H:%M:%S")
  end

  def weight_pounds(weight)
    #displays weights in pouns
    "#{weight} lbs"
  end

  def distance_feet_and_inches(inches)
    #displays distance in feet and inches
    divmod_output = inches.divmod(12)
    "#{divmod_output[0]} ft, #{divmod_output[1]} in"
  end

  def feet_and_inches_to_inches(feet, inches)
    #converts feet and inches to feet
    (feet * 12) + inches
  end

  def score_output
    if event.score_type.downcase == "time"
      seconds_to_min(self.score)
    elsif event.score_type.downcase == "points"
      self.score
    elsif event.score_type.downcase == "distance"
      distance_feet_and_inches(self.score)
    elsif event.score_type.downcase == "load"
      weight_pounds(self.score)
    else
      "Invalid Event Type"
    end
  end

end
