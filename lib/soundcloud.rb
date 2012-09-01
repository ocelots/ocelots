module Soundcloud
  def process_sc_embed_code object, owner
    return unless object
    return unless owner == current_person
    object.track = $1 if params[:sc_embed_code] =~ /tracks%2F(\d+)/
    object.secret = $1 if params[:sc_embed_code] =~ /secret_token%3D(s-[0-9a-zA-Z]+)/
    object.save
  end
end