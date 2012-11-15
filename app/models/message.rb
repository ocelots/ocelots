class Message < ActiveRecord::Base
  attr_accessible :team, :person, :content

  belongs_to :person
  belongs_to :team

  delegate :account, :full_name, to: :person

  def api_attributes
    att = attributes.except *%w{person_id team_id created_at updated_at}
    att[:timestamp] = created_at.to_i
    att[:person] = person.minimal_api_attributes
    att
  end
end