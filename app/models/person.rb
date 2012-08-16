# encoding: UTF-8

require 'ostruct'

class Person
  @people = []

  def self.add attributes
    person = OpenStruct.new attributes
    @people << person
  end

  add id: 'liyanhui',
      full_name: 'Li Yanhui',
      chinese_name: '李彦辉',
      email: 'yhli@thoughtworks.com'
  add id: 'tengyun',
      full_name: 'Téng Yǔn',
      chinese_name: '滕云',
      preferred_name: 'Chinese Tom',
      email: 'yteng@thoughtworks.com'
  add id: 'wangbiao',
      full_name: 'Wang Biao',
      email: 'biaowang@thoughtworks.com'
  add id: 'zhangyi',
      full_name: 'Zhang Yi',
      email: 'yizhang@thoughtworks.com'
  add id: 'markryall',
      full_name: 'Mark Ryall',
      chinese_name: '马克',
      email: 'mryall@thoughtworks.com'

  def self.all
    @people
  end
end