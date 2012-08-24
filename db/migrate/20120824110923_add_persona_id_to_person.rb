class AddPersonaIdToPerson < ActiveRecord::Migration
  def change
    add_column :people, :persona_id, :string

    Person.find(:all).each do |p|
      p.update_attribute :persona_id, Digest::MD5.hexdigest(p.email)
    end
  end
end
