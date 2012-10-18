class Message < ActiveRecord::Base
  attr_accessible :team, :person, :content

  belongs_to :person
  belongs_to :team
end