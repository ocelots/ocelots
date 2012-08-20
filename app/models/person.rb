class Person < ActiveRecord::Base
  attr_accessible :account, :chinese_name, :email, :full_name, :pinyin_name, :preferred_name

  has_many :memberships
  has_many :teams, through: :memberships
end
