class CarBlueprint < Blueprinter::Base
  identifier :id

  fields :number, :team, :driver_name

  field :updated_at, format: :datetime
  field :created_at, format: :datetime
end
