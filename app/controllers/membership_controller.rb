require 'soundcloud'

class MembershipController < ApplicationController
  include Soundcloud

  def soundcloud
    if membership = Membership.find(params[:id])
      process_sc_embed_code membership, membership.person
      redirect_to "/teams/#{membership.team.slug}"
    else
      redirect_to '/'
    end
  end
end