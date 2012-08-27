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
    if params[:override] && Person.omnipotent?(@current_user)
      @current_user = session[:email] = params[:override]
    end
    @current_user
  end

  def current_person
    @person = Person.find_by_email @current_user
    @person = Person.create email: @current_user unless @person
    @person
  end
end