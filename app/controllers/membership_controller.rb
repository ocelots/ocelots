class MembershipController < ApplicationController
  def soundcloud
    membership = Membership.find params[:id]
    process_sc_embed_code membership
    if membership
      membership.save
      redirect_to "/teams/#{membership.team.slug}"
    else
      redirect_to '/'
    end
  end
private
  def process_sc_embed_code membership
    return unless membership
    return unless membership.person == current_person
    membership.track = $1 if params[:sc_embed_code] =~ /tracks%2F(\d+)/
    membership.secret = $1 if params[:sc_embed_code] =~ /secret_token%3D(s-[0-9a-zA-Z]+)/
  end
end