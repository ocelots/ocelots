require 'spec_helper'

describe TeamsController do
  render_views
  
  before(:each) do
    @person = sign_in
    @organisation = Organisation.create(name: 'ThoughtWorks', domains: 'ThoughtWorks.com')
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
      team = Team.create(name: 'LSP', slug: 'lsp')
      get :show, :slug => team.slug
      response.should be_success
      assert_select '#join-team',{:value=> 'Join Team'}
    end
    it 'ensure a button display with quit team if we already joined this team' do

       team = @person.teams.create(name: 'LSP', slug: 'lsp')
       get :show ,:slug => team.slug
       response.should be_success

       assert_select '#join-team',{:value=> 'Quit Team'}
    end
  end

  describe :create do
    it 'creates team with organisations' do
      lambda do
        post :create, team: {name: 'LSP', slug: 'lsp'}, org_ids: [@organisation.id.to_s]
      end.should change(Team, :count).by(1)
      new_team = Team.find(:last)
      new_team.name.should == 'LSP'
      new_team.organisations.first.should == @organisation
    end
  end

  describe :join do
    it 'ensure person joins a team and create a membership between person and team' do
      team = Team.create(name: 'LSP', slug: 'lsp')
      lambda do
        post :join, :slug => team.slug
      end.should change(Membership, :count).by(1)
      new_membership = Membership.find(:last)
      new_membership.person.allowed_to_view_team?(new_membership.team).should == true
    end

    it 'ensure person can not join a team that he is not belong to the organisation of that team' do
      team = Team.create(name: 'LSP', slug: 'lsp')
      Organisation.find(:last).teams << team
      lambda do
        post :join, :slug => team.slug
      end.should change(Membership, :count).by(0)
    end
  end
  describe :quit do
    it 'ensure when people quit a team then destroy a membership' do
      team = Team.create(name: 'LSP', slug: 'lsp')
      lambda do
        post :join, :slug => team.slug
        post :quit, :slug => team.slug
      end.should change(Membership,:count).by(0)
    end
  end
end