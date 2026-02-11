class RaceParticipant < ApplicationRecord
  belongs_to :race
  belongs_to :car

  has_many :laps, dependent: :destroy

  validates :car_id, uniqueness: { scope: :race_id }
end
