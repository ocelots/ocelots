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
    before(:each) do
      @inviter = Person.create(email: 'test_inviter@inviter.com', full_name: 'Test Inviter', account: 'test_inviter')
      @invitee = Person.create(email: 'test@user.com', full_name: 'Test User', account: 'test_account')
      @team = @inviter.teams.create(name: 'Test Team', slug: 'test_team')
    end

		it 'ensure create pending membership' do
			mail = Object.new
			PersonMailer.should_receive(:invite).and_return(mail)
			mail.should_receive(:deliver)

			Organisation.create(name: 'User', domains: 'user.com')
			lambda do
			  Membership.create_pending_membership(@inviter, @invitee, @team)
			end.should change(Membership, :count).by(1)
    end

    it 'ensure do not invite someone who joined that team' do
      @invitee.teams << @team
      lambda do
        Membership.create_pending_membership(@inviter, @invitee, @team)
      end.should_not change(Membership, :count)
    end

    it 'ensure do not invite self' do
      lambda do
        Membership.create_pending_membership(@inviter, @inviter, @team)
      end.should_not change(Membership, :count)
    end

    it 'ensure do not invite someone more than once' do
      Membership.create team: @team, person: @invitee,pending_approval_token: uuid
      lambda do
        Membership.create_pending_membership(@inviter, @invitee, @team)
      end.should_not change(Membership, :count)
    end
  end
end