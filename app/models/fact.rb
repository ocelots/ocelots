class Fact < ActiveRecord::Base
  attr_accessible :content, :person_id, :person

  belongs_to :person
end