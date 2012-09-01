class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.integer :person_id
      t.text :content

      t.timestamps
    end
  end
end
