class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login

  def require_login
    redirect_to root_url unless logged_in?
  end

  def logged_in?
    !!current_user
  end

  def current_user
    return nil unless session[:email]
    @current_user = session[:email]
  end
end