class Team < ActiveRecord::Base
  attr_accessible :description, :name, :slug, :creator

  validates_presence_of :name
  validates_presence_of :slug
  validates_uniqueness_of :slug

  has_many :memberships
  has_many :people, through: :memberships
  belongs_to :creator, class_name: 'Person'
end