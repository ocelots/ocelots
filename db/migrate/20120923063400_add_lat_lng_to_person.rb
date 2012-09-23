class AddLatLngToPerson < ActiveRecord::Migration
  def change
    add_column :people, :lat, :float
    add_column :people, :lng, :float
  end
end
