require 'spec_helper'

describe TeamsController do
  render_views

  before(:each) do
    @person = sign_in
    @organisation = Organisation.create(name: 'ThoughtWorks', domains: 'thoughtworks.com')
  end

  describe :index do
    it 'fetches all organisations' do
      get :index
      all_organisations = assigns[:organisations]
      all_organisations.should_not be_nil
      all_organisations.should_not be_empty
    end
  end

  describe :show do

    it 'shows selected team' do
      team = @person.teams.create(name: 'LSP', slug: 'lsp')
      get :show, :slug => team.slug
      response.should be_success
      assigns[:team].should == team
    end

    it 'ensure a join button in some team we want to join' do
      team = @person.teams.create(name: 'LSP', slug: 'lsp')
      get :show, :slug => team.slug
      response.should be_success
      assert_select '#join-team', {:value => 'Join Team'}
    end
    it 'ensure a button display with quit team if we already joined this team' do

      team = @person.teams.create(name: 'LSP', slug: 'lsp')
      get :show, :slug => team.slug
      response.should be_success

      assert_select '#join-team', {:value => 'Quit Team'}
    end
  end

  describe :create do
    it "creates team with organisations,cause the person email=xx@gmail.com,so the team's organisation will be empty" do
      lambda do
        post :create, team: {name: 'LSP', slug: 'lsp'}, org_ids: [@organisation.id.to_s]
      end.should change(Team, :count).by(1)
      new_team = Team.find(:last)
      new_team.name.should == 'LSP'
      new_team.organisations.first.should == @organisation
    end
  end

  describe :join do

    it 'ensure person joins a team and modify this membership between person and team' do
      lambda do
        team = @person.teams.create(name: 'LSP', slug: 'lsp')
        post :join, :slug => team.slug
      end.should change(Membership, :count).by(1)
      new_membership = Membership.find(:last)
      new_membership.person.allowed_to_view_team?(new_membership.team).should == true

    end

    it 'ensure when person quit from a team then join it again,and it will not disappear in past situation' do
      team = @person.teams.create(name: 'LSP', slug: 'lsp')
      post :join, :slug => team.slug
      post :quit, :slug => team.slug
      post :join, :slug => team.slug
      membership = Membership.find(:last).ended.should == nil
    end

    it 'ensure person can not join a team that he is not belong to the organisation of that team' do
      team = Team.create(name: 'LSP', slug: 'lsp')
      lambda do
        post :join, :slug => team.slug
      end.should change(Membership, :count).by(0)
    end
  end
  describe :quit do
    it 'ensure when people quit a team then set the relationship ended,and the team should removed from approved team' do
      team = @person.teams.create(name: 'LSP', slug: 'lsp')
      post :join, :slug => team.slug
      lambda do
        post :quit, :slug => team.slug
      end.should change(Membership, :count).by(0)
      membership = Membership.find(:last)
      membership.status.should == 'past hidden'
      @person.approved_teams.include?(team).should_not == true
    end
  end

  describe :add do
    it "ensure add someone who are not in the organisation ,it should add the new person's organisation to the team" do
      mail = Object.new
      PersonMailer.should_receive(:invite).and_return(mail)
      mail.should_receive(:deliver)

      team = @person.teams.create(name: 'LSP', slug: 'lsp')
      @organisation = Organisation.create(name: 'Google', domains: 'google.com')
      post :add, :slug => team.slug, :emails => '"test" <test@google.com>'
      team.organisations.include?(@organisation).should == true
    end

	  it 'ensure invite some people to a team' do
		  mail = Object.new
		  PersonMailer.should_receive(:invite).and_return(mail)
		  mail.should_receive(:deliver)

		  mail_tw = Object.new
		  PersonMailer.should_receive(:invite).and_return(mail_tw)
		  mail_tw.should_receive(:deliver)

		  team = @person.teams.create(name: 'LSP', slug: 'lsp')
		  @organisation = Organisation.create(name: 'Google', domains: 'google.com')
		  @organisation_tw = Organisation.create(name: 'IBM', domains: 'ibm.com')
		  post :add, :slug => team.slug, :emails => 'test_name <test@google.com>,test_name2 <test2@ibm.com>'
		  team.organisations.include?(@organisation).should == true
		  team.organisations.include?(@organisation_tw).should == true
	  end
  end
end