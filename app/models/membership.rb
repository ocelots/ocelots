class Membership < ActiveRecord::Base
  attr_accessible :person, :team, :pending_approval_token, :started, :ended

  belongs_to :person
  belongs_to :team

  scope :approved, where('pending_approval_token is null')

  def self.create_pending_membership inviter, team, person
    membership = Membership.create team: team,
      person: person,
      pending_approval_token: UUIDTools::UUID.random_create.to_s
    PersonMailer.invite(inviter, membership).deliver
  end

  def pending?
    pending_approval_token
  end
end