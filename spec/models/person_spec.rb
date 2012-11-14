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

  describe :viewable_teams do
    let(:email) { 'fake_user@thoughtworks.com' }
    let(:person) { Person.create_for_email(email) }
    let(:blessed_organisation) { Organisation.create(name: 'ThoughtWorks', domains: 'thoughtworks.com') }
    let(:viewable_team) { blessed_organisation.teams.create(name: 'TW Project', slug: 'tw_project') }
    let(:non_blessed_organisation) { Organisation.create(name: 'Microsoft', domains: 'microsoft.com') }
    let(:non_viewable_team){ non_blessed_organisation.teams.create(name: 'MS Project', slug: 'ms_project') }
    let(:public_team){Team.create(name: 'Public Test Team', slug: 'public.com')}

    before(:each) do
      viewable_team.reload
      public_team.reload
      non_viewable_team.reload
    end

    it 'lists viewable teams but not non-viewable teams' do
      person.viewable_teams.should be_include(viewable_team)
      person.viewable_teams.should_not be_include(non_viewable_team)
      person.viewable_teams.should be_include(public_team)
    end
  end
end