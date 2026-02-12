class LapBlueprint < Blueprinter::Base
  identifier :id

  fields :lap_number, :lap_time, :race_participant_id

  field :updated_at, format: :datetime
  field :created_at, format: :datetime
  field :start_time, format: :datetime
  field :end_time,   format: :datetime
end
