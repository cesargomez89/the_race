class Lap < ApplicationRecord
  belongs_to :race_participant

  has_one :race, through: :race_participant
  has_one :car, through: :race_participant

  before_validation :set_lap_time

  validates :lap_number, :start_time, :end_time, :lap_time, presence: true
  validates :lap_number, uniqueness: { scope: :race_participant_id }, numericality: { only_integer: true, greater_than: 0 }
  validates :lap_time, numericality: { greater_than: 0 }
  validate :end_after_start

  default_scope { order(lap_number: :asc) }

  private

  def set_lap_time
    return unless start_time && end_time
    self.lap_time = (end_time - start_time) * 1000
  end

  def end_after_start
    return unless start_time && end_time
    errors.add(:end_time, "must be after start time") if end_time < start_time
  end
end
