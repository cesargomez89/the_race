class Lap < ApplicationRecord
  belongs_to :race_participant

  has_one :race, through: :race_participant
  has_one :car, through: :race_participant

  before_validation :set_lap_time_ms

  validates :lap_number, :start_time, :end_time, :lap_time_ms, presence: true
  validates :lap_number, uniqueness: { scope: :race_participant_id }
  validate :end_after_start

  private

  def set_lap_time_ms
    return unless start_time && end_time
    self.lap_time_ms = (end_time - start_time) * 1000
  end

  def end_after_start
    return unless start_time && end_time
    errors.add(:end_time, "must be after start time") if end_time < start_time
  end
end
