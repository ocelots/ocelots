require 'soundcloud'

class MembershipController < ApplicationController
  include Soundcloud

  def accept_invitation
    membership = Membership.find_by_pending_approval_token params[:token]
    if membership and current_person == membership.person
      membership.pending_approval_token = nil
      membership.save
      redirect_to "/teams/#{membership.team.slug}"
    end
  end

  def soundcloud
    if membership = Membership.find(params[:id])
      process_sc_embed_code membership, membership.person
      redirect_to "/teams/#{membership.team.slug}"
    else
      redirect_to '/'
    end
  end
end