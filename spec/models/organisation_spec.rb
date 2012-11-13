require 'spec_helper'

describe Organisation do
  it 'associates with multiple teams' do
    tw = Organisation.create(name: 'ThoughtWorks')
    tw.teams.create(name: 'Suncorp LSP')
    tw.teams.should have(1).team
  end
end
