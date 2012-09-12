require 'spec_helper'

describe Person do
  it 'should not generate valid user with non unique account' do
    person1 = Person.make! account: 'the_one'
    person2 = Person.make account: 'the_one'
    person2.should_not be_valid
  end

  describe '#create_for_email' do
    it 'should generate a valid person' do
      Person.create_for_email('user@email.com').should be_valid
    end
  end
end