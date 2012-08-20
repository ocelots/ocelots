class Membership < ActiveRecord::Base
  attr_accessible :ended, :person_id, :started, :team_id, :person, :team

  belongs_to :person
  belongs_to :team
end
