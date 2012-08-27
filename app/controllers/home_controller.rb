require 'persona'

class HomeController < ApplicationController
  include Persona

  skip_filter :require_login, only: [:index, :verify]

  def index
    if logged_in?
      redirect_url = session[:initial_url] || :home
      session[:initial_url] = nil
      redirect_to redirect_url
    else
      render layout: 'landing'
    end
  end

  def home
    @teams = current_person.teams
  end

  def logout
    session[:email] = nil
    redirect_to root_url
  end

  def verify
    response = {}
    verify_persona { |email, response| session[:email] = email }
    render json: response
  end
end