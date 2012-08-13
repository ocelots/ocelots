class ApplicationController < ActionController::Base
  protect_from_forgery

  def logged_in?
    !!current_user
  end

  def current_user
    return nil unless session[:email]
    @current_user ||= session[:email]
  end
end