require 'uuid_generator'

class Membership < ActiveRecord::Base
  extend UuidGenerator

  attr_accessible :person, :team, :pending_approval_token, :started, :ended

  belongs_to :person
  belongs_to :team

  scope :approved, where('pending_approval_token is null')

  def self.create_pending_membership inviter, team, person
    membership = Membership.create team: team,
      person: person,
      pending_approval_token: uuid
    PersonMailer.invite(inviter, membership).deliver
  end

  def pending?
    pending_approval_token
  end

  def approve
    update_attributes pending_approval_token: nil
  end

  def self.api_attributes_for user
    user.memberships.map do |m|
      attr = m.attributes.except(*%w{id person_id team_id pending_approval_token})
      attr[:team] = m.team.attributes.except(*%w{id creator_id})
      attr
    end
  end
end