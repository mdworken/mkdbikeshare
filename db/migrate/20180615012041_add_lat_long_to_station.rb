class AddLatLongToStation < ActiveRecord::Migration[5.2]
  def change
  	add_column :stations, :latitude, :decimal, {:precision=>10, :scale=>6}
    add_column :stations, :longitude, :decimal, {:precision=>10, :scale=>6}
  end
end
