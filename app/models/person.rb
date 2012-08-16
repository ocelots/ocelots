# encoding: UTF-8

require 'ostruct'

class Person
  @people = []

  def self.add attributes
    person = OpenStruct.new attributes
    @people << person
  end

  add id: 'liyanhui',
      family_name: 'Li',
      given_name: 'Yanhui',
      chinese_name: '李彦辉',
      email: 'yhli@thoughtworks.com'
  add id: 'tengyun',
      family_name: 'Téng',
      given_name: 'Yǔn',
      chinese_name: '滕云',
      preferred_name: 'Chinese Tom',
      email: 'yteng@thoughtworks.com'
  add id: 'wangbiao',
      family_name: 'Wang',
      given_name: 'Biao',
      email: 'biaowang@thoughtworks.com'
  add id: 'zhangyi',
      family_name: 'Zhang',
      given_name: 'Yi',
      email: 'yizhang@thoughtworks.com'
  add id: 'markryall',
      family_name: 'Ryall',
      given_name: 'Mark',
      chinese_name: '马克',
      email: 'mryall@thoughtworks.com'

  def self.all
    @people
  end
end