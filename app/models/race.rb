class Race < ApplicationRecord
  has_many :race_participants, dependent: :destroy
  has_many :cars, through: :race_participants
  has_many :laps, through: :race_participants

  validates :name, :track_name, :start_time, :end_time, presence: true
  validates :name, uniqueness: true

  # Coordinates are stored as decimal(9,6) instead of float to avoid precision errors.
  # valid Earth coordinate ranges.
  validates :start_latitude, :finish_latitude,
    numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }

  validates :start_longitude, :finish_longitude,
    numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
end
