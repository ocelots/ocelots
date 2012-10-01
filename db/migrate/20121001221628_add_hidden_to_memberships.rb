class AddHiddenToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :hidden, :boolean
  end
end
