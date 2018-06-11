class AddNameToStations < ActiveRecord::Migration[5.2]
  def change
    add_column :stations, :name, :string
  end
end
