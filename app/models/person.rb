class Person < ActiveRecord::Base
  attr_accessible :account, :chinese_name, :email, :full_name, :pinyin_name, :preferred_name
end
