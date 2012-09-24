module ApplicationHelper
  def image_for person
    image_tag person.photo? ? person.photo.url(:square) : '/assets/silhouette.png'
  end

  def phone_link_to phone
    phone.blank? ? '' : link_to(phone,"tel://#{phone.gsub(/\D/,'')}")
  end
end