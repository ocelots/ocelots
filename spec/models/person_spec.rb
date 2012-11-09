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

  it 'ensures user has a full name' do
    Person.make(full_name: nil).should_not be_valid
    Person.make(full_name: "").should_not be_valid
  end

  it "ensures user's photo format should be valid image format"

  it "ensures the profile id a valid string" do
    Person.make(account: nil).should_not be_valid
    Person.make(account: '').should_not be_valid
  end

  describe '#create_for_email' do
    let(:email) { 'user@email.com' }
    let(:created_person) { Person.create_for_email(email) }

    it 'should generate a valid person with full name' do
      created_person.should be_valid
      created_person.full_name.should == 'user'
    end

    it 'should calculate persona_id from email' do
      created_person.persona_id.should == Digest::MD5.hexdigest(email)
    end

    it 'should automaticaly populate auth_token' do
      created_person.auth_token.should =~ /\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/
    end

    it 'should automaticaly populate account' do
      created_person.account.should =~ /\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/
    end
  end
end