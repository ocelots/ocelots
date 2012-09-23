class AddLatLngToPerson < ActiveRecord::Migration
  def change
    add_column :people, :lat, :integer
    add_column :people, :lng, :integer
  end
end
