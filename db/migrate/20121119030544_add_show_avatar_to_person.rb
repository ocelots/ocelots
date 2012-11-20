class AddShowAvatarToPerson < ActiveRecord::Migration
  def change
    add_column :people, :show_avatar, :boolean ,:default => true # Choose show avatar in home page
  end
end
