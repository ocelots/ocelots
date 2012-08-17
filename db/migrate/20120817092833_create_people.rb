class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :account
      t.string :full_name
      t.string :chinese_name
      t.string :preferred_name
      t.string :email
      t.string :pinyin_name

      t.timestamps
    end
  end
end
