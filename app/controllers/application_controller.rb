require 'omnipotence'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login

  def require_login
    unless logged_in?
      session[:initial_url] = request.url
      redirect_to root_url
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    return nil unless session[:email]
    return @current_user if @current_user
    @current_user = session[:email]
    if params[:override] && Omnipotence.omnipotent?(@current_user)
      @current_user = session[:email] = params[:override]
    end
    @current_user
  end

  def current_person
    return @current_person if @current_person
    @current_person = Person.find_by_email current_user
    @current_person = Person.create_for_email current_user unless @current_person
    @current_person
  end
end