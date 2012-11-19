require 'spec_helper'
require 'paperclip/matchers'

describe Person do
  include Paperclip::Shoulda::Matchers

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

  it "ensures the profile id a valid string" do
    Person.make(account: nil).should_not be_valid
    Person.make(account: '').should_not be_valid
  end

  it 'ensures the photo attachment has correct mime type' do
    should validate_attachment_content_type(:photo).
      allowing('image/jpeg', 'image/png', 'image/gif').
      rejecting('text/plain', 'text/xml')
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
    let(:joined_team){person.teams.create(name: 'Joined Team', slug: 'joined.com')}
    before(:each) do
      viewable_team.reload
      public_team.reload
      non_viewable_team.reload
    end

    it 'lists viewable teams but not non-viewable teams & joined teams' do
      person.viewable_teams.should be_include(viewable_team)
      person.viewable_teams.should_not be_include(non_viewable_team)
      person.viewable_teams.should_not be_include(joined_team)
    end
  end

  describe 'person team membership' do

    it 'leave team correctly' do
      team = Team.create(name: 'LSP', slug: 'lsp')
      person = Person.create_for_email("user@email.com")
      person.teams << team

      person.leave(team)
      membership = Membership.find(:last)
      membership.status.should == 'past hidden'
    end

  end

  describe "person's avatar to show in homepage" do
    it 'ensure the default value of show_avatar is true when create a person' do
      person = Person.create_for_email("user@email.com")
      person.show_avatar.should == true
    end

  end

  describe :get_organisation_by_email do
    it 'ensure return the accurate organisation by email' do
      tw = Organisation.create(name: 'Sun Corp',domains:'suncorp.com')
      person = Person.create_for_email('test@suncorp.com')
      person.get_organisation_by_email.name.should == tw.name
    end

    #it 'ensure return the accurate orgisation by email when some orgisation has several domains' do
    #  tw = Organisation.create(name: 'ThoughtWorks',domains:'thoughtworks.com,tw.com')
    #  person = Person.create_for_email('test@thoughtworks.com')
    #  person.get_organisation_by_email.name.should == tw.name
    #end

  end

end