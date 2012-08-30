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
    logger.info "attempting to attach soundcloud information to membership #{membership.id}"
    return unless membership.person == current_person
    if params[:sc_embed_code] =~ /tracks%2F(\d+)%3Fsecret_token%3D([^&]+)&/
      logger.info "matched soundcloud track #{$1} and secret #{$2}"
      membership.track = $1
      membership.secret = $2
      membership.save
    else
      logger.info 'no match'
    end
  end
end