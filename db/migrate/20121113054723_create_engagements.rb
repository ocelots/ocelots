class CreateEngagements < ActiveRecord::Migration
  def change
    create_table :engagements do |t|
      t.integer :organisation_id
      t.integer :team_id
    end
  end
end
