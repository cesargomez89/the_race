class Lap < ApplicationRecord
  belongs_to :race_participant

  has_one :race, through: :race_participant
  has_one :car, through: :race_participant

  validates :lap_number, :start_time, :end_time, :lap_time_ms, presence: true
  validates :lap_number, uniqueness: { scope: :race_participant_id }
end
