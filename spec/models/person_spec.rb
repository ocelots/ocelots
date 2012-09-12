require 'spec_helper'

describe Person do
  it 'should ensure users have a unique auth_token' do
    Person.make! auth_token: 'the_one'
    Person.make(auth_token: 'the_one').should_not be_valid
  end

  it 'should ensure users have a unique account' do
    Person.make! account: 'the_one'
    Person.make(account: 'the_one').should_not be_valid
  end

  describe '#create_for_email' do
    it 'should generate a valid person' do
      Person.create_for_email('user@email.com').should be_valid
    end
  end
end