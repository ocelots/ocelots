require 'spec_helper'

describe TeamsController do
  before(:each) do
    session[:email] = 'do.not.make.me.test@gmail.com'
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

  describe :create do
    it 'creates team with organisations' do
      lambda do
        post :create, team: {name: 'LSP', slug: 'lsp'}, org_ids: [@organisation.id.to_s]
      end.should change(Team, :count).by(1)
      new_team = Team.find(:last)
      new_team.name.should == 'LSP'
      new_team.organisations.should be_include(@organisation)
    end
  end
end