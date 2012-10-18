class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :person_id
      t.integer :team_id
      t.text :content

      t.timestamps
    end
  end
end
