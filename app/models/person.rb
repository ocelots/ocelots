class Person < ActiveRecord::Base
  attr_accessible :account, :chinese_name, :email, :full_name, :pinyin_name, :preferred_name, :photo

  has_many :memberships
  has_many :teams, through: :memberships

  has_attached_file :photo,
                     { :styles =>
                              {
                                 :thumb => "40x60#",
                                 :small => "80x120#"
                              }}.merge( Rails.application.config.paperclip_storage_options )

  def persona_id
    Digest::MD5.hexdigest(email)
  end
end
