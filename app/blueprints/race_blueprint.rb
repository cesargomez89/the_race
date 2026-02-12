class RaceBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :track_name, :start_latitude, :start_longitude,
         :finish_latitude, :finish_longitude

  field :updated_at, format: :datetime
  field :created_at, format: :datetime
  field :start_time, format: :datetime
  field :end_time,   format: :datetime
end
