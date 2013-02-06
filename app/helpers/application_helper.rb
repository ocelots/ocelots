module ApplicationHelper
  def image_for person
    image_tag person.photo? ? person.photo.url(:square) : person.gravatar_url ,class:'avatar-image'
  end

  def image_for_without_radius  person
    image_tag person.photo? ? person.photo.url(:square) : person.gravatar_url
  end

  def phone_link_to phone
    phone.blank? ? '' : link_to(phone,"tel://#{phone.gsub(/\D/,'')}")
  end

  def markdown string
    RDiscount.new(string||'', :smart, :filter_html, :safelink).to_html.html_safe
  end
end