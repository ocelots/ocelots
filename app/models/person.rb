require 'omnipotence'
require 'uuid_generator'

class Person < ActiveRecord::Base
  include Omnipotence
  include UuidGenerator

  before_create :create_persona_id

  attr_accessible :email, :full_name, :chinese_name, :pinyin_name, :preferred_name
  attr_accessible :photo, :persona_id, :account
  attr_accessible :phone, :twitter, :facebook, :weibo, :appnet, :github, :url

  validates_uniqueness_of :account

  has_many :facts
  has_many :memberships
  has_many :teams, through: :memberships

  has_attached_file :photo,
                     { :styles =>
                              {
                                 :thumb => "40x60#",
                                 :small => "80x120#"
                              }}.merge( Rails.application.config.paperclip_storage_options )

  def self.create_for_email email
    Person.create email: email, account: uuid
  end

  def create_persona_id
    self.persona_id = Digest::MD5.hexdigest(email)
  end
end