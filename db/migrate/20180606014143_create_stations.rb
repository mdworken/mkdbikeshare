class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.integer :num_bikes
      t.integer :num_docks

      t.timestamps
    end
  end
end
