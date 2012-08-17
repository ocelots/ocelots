# encoding: UTF-8

require 'ostruct'

class Person
  @people = []

  def self.add attributes
    person = OpenStruct.new attributes
    @people << person
  end

  add id: 'liyanhui',
      full_name: 'Li Yànhuī',
      chinese_name: '李彦辉',
      email: 'yhli@thoughtworks.com'

  add id: 'tengyun',
      full_name: 'Téng Yǔn',
      chinese_name: '滕云',
      preferred_name: 'Chinese Tom',
      email: 'yteng@thoughtworks.com'

  add id: 'wangbiao',
      full_name: 'Wáng Biāo',
      chinese_name: '王彪',
      email: 'biaowang@thoughtworks.com'

  add id: 'zhangyi',
      full_name: 'Zhāng Yì',
      chinese_name: '张逸',
      email: 'yizhang@thoughtworks.com'

  add id: 'markryall',
      full_name: 'Mark Ryall',
      pinyin_name: 'Mǎkè',
      chinese_name: '马克',
      email: 'mryall@thoughtworks.com'

  def self.all
    @people
  end
end