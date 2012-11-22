class AddFilckrToPerson < ActiveRecord::Migration
  def change
    add_column   :people  ,:flickr , :string
  end
end
