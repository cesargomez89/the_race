class CreateCars < ActiveRecord::Migration[8.1]
  def change
    create_table :cars do |t|
      t.integer :number
      t.string :team
      t.string :driver_name

      t.timestamps
    end
  end
end
