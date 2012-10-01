require 'omnipotence'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login
  helper_method :current_person

  def require_login
    unless logged_in?
      session[:initial_url] = request.url
      redirect_to root_url
    end
  end

  def logged_in?
    !!current_person
  end

  def current_person
    return @current_person if @current_person

    if params[:auth_token]
      @current_person = Person.find_by_auth_token params[:auth_token]
      if @current_person
        session[:email] = @current_person.email
        return @current_person
      end
    end

    return unless session[:email]

    if params[:override] && Omnipotence.omnipotent?(session[:email])
      session[:email] = params[:override]
    end

    @current_person = Person.find_by_email session[:email]
    @current_person = Person.create_for_email session[:email] unless @current_person
    @current_person
  end
end