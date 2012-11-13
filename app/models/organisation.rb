class Organisation < ActiveRecord::Base
  attr_accessible :name, :domains
  has_many :engagements
  has_many :teams, :through => :engagements
end
