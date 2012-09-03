class Person < ActiveRecord::Base
  before_create :create_persona_id

  attr_accessible :email, :full_name, :chinese_name, :pinyin_name, :preferred_name
  attr_accessible :photo, :persona_id
  attr_accessible :phone, :twitter, :facebook, :weibo, :appnet, :github, :url

  has_many :facts
  has_many :memberships
  has_many :teams, through: :memberships

  has_attached_file :photo,
                     { :styles =>
                              {
                                 :thumb => "40x60#",
                                 :small => "80x120#"
                              }}.merge( Rails.application.config.paperclip_storage_options )

  def self.omnipotent? user
    (ENV['OMNIPOTENT_USERS'] || '').split(',').include? user
  end

  def create_persona_id
    self.persona_id = Digest::MD5.hexdigest(email)
  end

  def omnipotent?
    Person.omnipotent? email
  end

  def email_domain
    email.split('@').last
  end

  def blessed?
    return true if omnipotent?
    (ENV['BLESSED_DOMAINS'] || '').split(',').include? email_domain
  end
end
