require 'omnipotence'
require 'uuid_generator'

class Person < ActiveRecord::Base
  include Omnipotence
  extend UuidGenerator
  include Gravtastic ,UuidGenerator
  gravtastic  :secure => false,
              :size => 300

  attr_accessible :email, :persona_id, :account, :auth_token
  attr_accessible :full_name, :chinese_name, :pinyin_name, :preferred_name
  attr_accessible :photo, :phone
  attr_accessible :url, :twitter, :facebook, :weibo, :appnet, :github ,:flickr
  attr_accessible :lat, :lng
  attr_accessible :show_avatar


  validates_uniqueness_of :account
  validates_uniqueness_of :auth_token

  validates_presence_of :full_name ,:message => 'cannot be blank.'
  validates_presence_of :account, :message => 'cannot be blank'

  has_many :facts
  has_many :memberships
  has_many :teams, through: :memberships

  validates_attachment_content_type :photo, :content_type=>['image/jpeg', 'image/png', 'image/gif']

  has_attached_file :photo, {
  styles: { square: "300x300#" }
  }.merge(Rails.application.config.paperclip_storage_options)

  def self.create_for_email email
    Person.create email: email,
    persona_id: Digest::MD5.hexdigest(email),
    full_name: email.split("@")[0],
    account: uuid,
    auth_token: uuid
  end

  def api_attributes
    att = attributes.except(*%w{id auth_token photo_file_name photo_content_type photo_file_size})
    att[:photo_url] = photo.url if photo.exists?
    att
  end

  def minimal_api_attributes
    attributes.slice *%w{email full_name}
  end

  def approved_teams
    memberships.approved.includes('team').map &:team
  end

  def allowed_to_view? person
    return false unless person
    omnipotent? or person == self or !(teams & person.approved_teams).empty?
  end

  def allowed_to_view_team? team
    return false unless team

    blessed?(team) or team.creator == self or teams.include?(team)
  end

  def viewable_teams
    Team.find(:all).select{|team| allowed_to_view_team?(team)} - approved_teams
  end

  def blessed?(team)
    return true if omnipotent?
    team.blessed?(email_domain)
  end

  def email_domain
    email.split('@').last
  end

  def leave (team)
    Membership.where(team_id: team.id,person_id: id).first.leave
  end

  def join(team)
    if  Membership.where(team_id: team.id,person_id: id).empty?
      teams << team
    else
      Membership.where(team_id: team.id,person_id: id).first.approve
    end

  end

  def organisation
    Organisation.where('domains like ?',email_domain).first
  end

  def refresh_auth_token
    update_attributes auth_token: uuid
    auth_token
  end

  def display_name
    full_name || '^@^'
  end

  def self.to_person(email)
	  person = Person.find_by_email email
	  person = Person.create_for_email email unless person
	  person
  end
end