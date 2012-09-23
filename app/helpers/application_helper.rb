module ApplicationHelper
  def image_for person
    image_tag person.photo? ? person.photo.url(:square) : '/assets/silhouette.png'
  end
end