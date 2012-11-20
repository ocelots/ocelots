require 'spec_helper'
require 'paperclip/matchers'

describe Team do

  before(:each) do
    @person = sign_in
    @team = @person.teams.create(name: 'LSP', slug: 'lsp')
    @organisation = Organisation.create(name: 'Google', domains: 'google.com')
  end

  #describe :add_to_organisation do
  #
  #  it 'ensure when a team add an organisation ,the organisations will change by 1' do
  #
  #       @team.add_to_organisation
  #        @team.organisations.count should change_by 1
  #  end
  #
  #end

end