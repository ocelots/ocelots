class Team < ActiveRecord::Base
  attr_accessible :description, :name, :slug, :creator

  validates_presence_of :name
  validates_presence_of :slug
  validates_uniqueness_of :slug

  has_many :memberships
  has_many :people, through: :memberships
  has_many :messages
  has_many :engagements
  has_many :organisations, through: :engagements
  belongs_to :creator, class_name: 'Person'


  def api_attributes params={}
    att = attributes.except *%w{id creator_id}
    att[:members] = memberships.includes(:person).approved.map(&:person).map(&:api_attributes) if params[:include] and params[:include].include? :members
    att
  end

  def blessed?(domain)
    organisations.map{|org| org.domains.split(',')}.flatten.include?(domain)
  end

  def add_to (organisation)
	  if organisation
		  organisations << organisation
	  end
  end
end