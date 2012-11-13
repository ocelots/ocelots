require 'spec_helper'

describe Membership do
  it 'delegates fields to associated objects' do
    person = Person.create!(email: 'test@user.com', full_name: 'Test User', account: 'test_account')
    team = person.teams.create!(name: 'Test Team', slug: 'test_team')
    membership = person.memberships.first
    
    membership.email.should == 'test@user.com'
    membership.team_name.should == 'Test Team'
  end
end