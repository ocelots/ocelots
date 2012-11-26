require 'spec_helper'

describe Membership do
  it 'delegates fields to associated objects' do
    person = Person.create!(email: 'test@user.com', full_name: 'Test User', account: 'test_account')
    team = person.teams.create!(name: 'Test Team', slug: 'test_team')
    membership = person.memberships.first

    membership.email.should == 'test@user.com'
    membership.team_name.should == 'Test Team'
  end

	describe :create_pending_membership do
		it 'ensure create pending membership' do
			mail = Object.new
			PersonMailer.should_receive(:invite).and_return(mail)
			mail.should_receive(:deliver)

			inviter_person = Person.create(email: 'test_inviter@inviter.com', full_name: 'Test Inviter', account: 'test_inviter')
			person = Person.create(email: 'test@user.com', full_name: 'Test User', account: 'test_account')
			Organisation.create(name: 'User', domains: 'user.com')
			team = inviter_person.teams.create(name: 'Test Team', slug: 'test_team')
			lambda do
			  Membership.create_pending_membership(inviter_person, person, team)
			end.should change(Membership, :count).by(1)
		end
	end
end