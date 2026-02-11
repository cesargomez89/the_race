FactoryBot.define do
  factory :race do
    sequence(:name) { |n| "F1 Race #{n}" }
    track_name { "Track 1" }
    start_time { Time.current }
    end_time { 1.hour.from_now }
    start_latitude { 38.8951 }
    start_longitude { -77.0364 }
    finish_latitude { 38.8951 }
    finish_longitude { -77.0364 }
  end
end
