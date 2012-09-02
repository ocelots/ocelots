class AddCreatorToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :creator_id, :integer
  end
end
