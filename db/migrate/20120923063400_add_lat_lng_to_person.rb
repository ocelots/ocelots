class AddLatLngToPerson < ActiveRecord::Migration
  def change
    add_column :people, :lat, :real
    add_column :people, :lng, :real
  end
end
