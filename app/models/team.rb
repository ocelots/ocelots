class Team < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :memberships
  has_many :people, through: :memberships
end
