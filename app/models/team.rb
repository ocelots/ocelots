class Team < ActiveRecord::Base
  attr_accessible :description, :name, :slug

  has_many :memberships
  has_many :people, through: :memberships
end
