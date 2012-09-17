require 'omnipotence'
require 'uuid_generator'

class Person < ActiveRecord::Base
  include Omnipotence
  extend UuidGenerator

  attr_accessible :email, :persona_id, :account, :auth_token
  attr_accessible :full_name, :chinese_name, :pinyin_name, :preferred_name
  attr_accessible :photo, :phone
  attr_accessible :url, :twitter, :facebook, :weibo, :appnet, :github

  validates_uniqueness_of :account
  validates_uniqueness_of :auth_token

  has_many :facts
  has_many :memberships
  has_many :teams, through: :memberships

  has_attached_file :photo, {
    styles: {
         thumb: "40x60#",
         small: "80x120#"
      }
    }.merge(Rails.application.config.paperclip_storage_options)

  def self.create_for_email email
    Person.create email: email,
      persona_id: Digest::MD5.hexdigest(email),
      account: uuid,
      auth_token: uuid
  end

  def api_attributes
    att = attributes.except(*%w{id auth_token photo_file_name photo_content_type photo_file_size})
    att[:photo_url] = photo.url if photo.exists?
    att
  end

  def approved_teams
    memberships.approved.includes('team').map &:team
  end

  def allowed_to_view? person
    return false unless person
    return true if blessed? or person == self
    !(teams & person.approved_teams).empty?
  end
end