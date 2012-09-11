require 'soundcloud'

class MembershipController < ApplicationController
  include Soundcloud

  def accept_invitation
    membership = Membership.find_by_pending_approval_token params[:token]
    if membership and membership.person == current_person
      membership.approve
      redirect_to "/teams/#{membership.team.slug}"
    end
  end

  def soundcloud
    with_membership do |membership|
      process_sc_embed_code membership, membership.person
      redirect_to "/teams/#{membership.team.slug}"
    end
  end

  def approve
    with_membership do |membership|
      membership.approve if membership.person == current_person
      redirect_to "/teams/#{membership.team.slug}"
    end
  end

  def leave
    with_membership do |membership|
      membership.destroy if membership.person == current_person
      redirect_to '/'
    end
  end
private
  def with_membership
    if membership = Membership.find(params[:id])
      yield membership
    else
      redirect_to '/'
    end
  end
end