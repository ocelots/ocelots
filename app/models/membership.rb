require 'uuid_generator'

class Membership < ActiveRecord::Base
  extend UuidGenerator

  attr_accessible :person, :team, :pending_approval_token
  attr_accessible :started, :ended, :hidden, :role

  belongs_to :person
  belongs_to :team
  delegate :email, :phone, :account, to: :person
  delegate :track, :photo, :gravatar_url, to: :person, prefix: true
  delegate :name, :slug, :description, :people, to: :team, prefix: true

  scope :approved, where('pending_approval_token is null and ended is null')
  scope :pendings, where('pending_approval_token is not null')

  def self.create_pending_membership inviter, invitee, team
	  unless invitee.teams.include? team
		  membership = Membership.create team: team, person: invitee,pending_approval_token: uuid
      PersonMailer.invite(inviter, membership).deliver
		  organisation = invitee.organisation
		  team.add_to organisation
	  end
  end

  def status
    return 'future hidden' if started and started > Date.today
    return 'past hidden' if ended and Date.today >= ended
    return 'silent hidden' if hidden
    'current'
  end

  def pending?
    pending_approval_token
  end

  def approve
    update_attributes pending_approval_token: nil
    if ended
      update_attributes ended: nil
    end
  end

  def leave
    update_attributes ended: Date.today
  end

  def self.api_attributes_for user
    user.memberships.includes('team').map do |m|
      attr = m.attributes.except(*%w{id person_id team_id pending_approval_token})
      attr[:team] = m.team.api_attributes
      attr
    end
  end
end