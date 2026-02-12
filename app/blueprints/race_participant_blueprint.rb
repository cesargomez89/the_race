class RaceParticipantBlueprint < Blueprinter::Base
  identifier :id

  fields :race_id, :car_id

  field :updated_at, format: :datetime
  field :created_at, format: :datetime
end
