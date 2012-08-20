class AddSlugToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :slug, :string
  end
end
