class AddScTrackAndSecretToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :track, :integer
    add_column :memberships, :secret, :string
  end
end
