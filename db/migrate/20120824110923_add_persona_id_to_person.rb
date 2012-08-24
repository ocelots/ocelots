class AddPersonaIdToPerson < ActiveRecord::Migration
  def change
    add_column :people, :persona_id, :string
  end
end
