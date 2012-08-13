module ApplicationHelper
  def link_for_login_status
    logged_in? ? link_to('logout', logout_url) : link_to('login', '#', id: :authenticate)
  end

  def logged_in?
    !!@current_user
  end
end