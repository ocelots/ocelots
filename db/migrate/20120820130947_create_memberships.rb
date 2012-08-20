class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :person_id
      t.integer :team_id
      t.date :started
      t.date :ended

      t.timestamps
    end
  end
end
