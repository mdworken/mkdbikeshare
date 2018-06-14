class CreateLocationQueries < ActiveRecord::Migration[5.2]
  def change
    create_table :location_queries do |t|
      t.string :query
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6

      t.timestamps
    end
  end
end
