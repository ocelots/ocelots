class AddTrackAndSecretToPeople < ActiveRecord::Migration
  def change
    add_column :people, :track, :integer
    add_column :people, :secret, :string
  end
end
