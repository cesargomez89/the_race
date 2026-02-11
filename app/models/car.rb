class Car < ApplicationRecord
  has_many :race_participants, dependent: :destroy
  has_many :races, through: :race_participants
  has_many :laps, through: :race_participants

  validates :number, :team, :driver_name, presence: true
  validates :number, uniqueness: { scope: :team }

  validates :number, numericality: { only_integer: true, greater_than: 0 }
end
