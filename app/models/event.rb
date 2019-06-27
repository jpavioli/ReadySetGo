class Event < ApplicationRecord

    #associations
    belongs_to :competition
    has_many :scores
    has_many :teams, through: :scores

    #validations
    validates :title, presence: true
    validates :description, presence: true
    validates :description, length: {minimum: 10}
    validates :score_type, presence: true
    validates :competition_id, presence: true

    #methods
    def winner
      #returns the top team
      if score_type.downcase == "time"
        scores.min_by{|event_score| event_score.score}.team.name
      elsif score_type.downcase == "points"
        scores.max_by{|event_score| event_score.score}.team.name
      elsif score_type.downcase == "distance"
        scores.max_by{|event_score| event_score.score}.team.name
      elsif score_type.downcase == "load"
        scores.max_by{|event_score| event_score.score}.team.name
      else
        "Invalid Score type"
      end
    end

    def rankings
      #returns a sorted list based on the finsihing order
      if score_type.downcase == "time"
        scores.sort{|a,b| a.score <=> b.score}
      elsif score_type.downcase == "points"
        scores.sort{|b,a| a.score <=> b.score}
      elsif score_type.downcase == "distance"
        scores.sort{|b,a| a.score <=> b.score}
      elsif score_type.downcase == "load"
        scores.sort{|b,a| a.score <=> b.score}
      else
        "Invalid Score type"
      end
    end

    def average_score
      #returns the average score for the event
      if scores == []
        "Event has not been Scored."
      else
        avg = scores.map{|score| score.score }.inject{ |sum, score| sum + score } / scores.size
        if score_type.downcase == "time"
          Time.at(avg).utc.strftime("%H:%M:%S")
        elsif score_type.downcase == "points"
          avg
        elsif score_type.downcase == "distance"
          divmod_output = avg.divmod(12)
          "#{divmod_output[0]} ft, #{divmod_output[1]} in"
        elsif score_type.downcase == "load"
          "#{avg} lbs"
        else
          "Invalid Event Type"
        end
      end
    end

end
