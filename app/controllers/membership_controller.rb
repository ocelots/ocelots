class MembershipController < ApplicationController
  def soundcloud
    membership = Membership.find params[:id]
    process_sc_embed_code membership
    if membership
      redirect_to "/teams/#{membership.team.slug}"
    else
      redirect_to '/'
    end
  end
private
  def process_sc_embed_code membership
    return unless membership
    return unless membership.person == current_person
  end
end