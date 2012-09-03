class AddPhoneAndSomeSocialNetworkStuffToPerson < ActiveRecord::Migration
  def change
    add_column :people, :phone, :string
    add_column :people, :twitter, :string
    add_column :people, :facebook, :string
    add_column :people, :weibo, :string
    add_column :people, :appnet, :string
    add_column :people, :github, :string
    add_column :people, :url, :string
  end
end
