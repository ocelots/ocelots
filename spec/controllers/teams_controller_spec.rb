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
end