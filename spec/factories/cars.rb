# frozen_string_literal: true

FactoryBot.define do
  factory :car do
    sequence(:number) { |n| n }
    team { "Team 1" }
    driver_name { "Driver 1" }
  end
end
