# frozen_string_literal: true

FactoryBot.define do
  factory :lap do
    race_participant
    sequence(:lap_number) { |n| n }
    start_time { Time.current }
    end_time { 1.minute.from_now }
  end
end
