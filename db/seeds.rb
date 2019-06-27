require 'rubygems'
require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Athlete.destroy_all
Team.destroy_all
Event.destroy_all
Competition.destroy_all
Score.destroy_all

2.times do
        Competition.create(
        name: Faker::TvShows::BreakingBad.episode,
        description: Faker::Hipster.paragraph(3),
        location: Faker::Movies::StarWars.planet,
        datetime: Faker::Time.forward(5, :morning),
        competition_manager_id: 1,
        status: "Scheduled"
        )
end



3.times do
    Team.create(
        name: Faker::Team.name,
        location: Faker::Team.state,
        sponsor: Faker::Company.name,
        team_type: Faker::Team.sport,
        mascot: Faker::Team.mascot,
        team_manager_id: 1,
        competition_id: Competition.all.sample.id
    )
end
30.times do
    Athlete.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      hometown: Faker::Address.city,
      state: Faker::Address.state_abbr,
      bio: Faker::Hipster.paragraph(2),
      gender: Faker::Gender.binary_type,
      jersey_number: (0..99).uniq.sample,
      age:(18..32).to_a.sample,
      weight: Faker::Number.within(100..200),
      height: Faker::Number.within(48..84),
      team_id: Team.all.sample.id
    )
end

5.times do
    Event.create(
    title: Faker::Hipster.sentence(3),
    description: Faker::Hipster.paragraph(2),
    time: Faker::Time.forward(6, :morning),
    score_type: ["time", "points","distance","load"].sample,
    event_manager_id: 1,
    competition_id: Competition.all.sample.id)
end

50.times do
    score = Score.create(
    score: (1..99).to_a.sample,
    event_id: Event.all.sample.id,
    team_id: Team.all.sample.id
    )
end


