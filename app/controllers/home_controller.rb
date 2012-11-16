require 'persona'
require 'net/http'
require 'google_api_ext'

class HomeController < ApplicationController
  include Persona

  skip_filter :require_login, only: [:index, :verify, :verify_g, :verify_g_callback]

  def index
    if logged_in?
      redirect_url = session[:initial_url] || :teams
      session[:initial_url] = nil
      redirect_to redirect_url
    else
      @people = Person.find(:all,:order => "RANDOM()", :limit => 4)
      render layout: 'landing'
    end
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

  def verify_g
    @client = Google::APIClient.build(request.host_with_port)
    url = @client.authorization.authorization_uri.to_s
    session[:google_auth] = @client.to_yaml

    redirect_to url
  end

  def verify_g_callback
    google_auth = YAML.load(session[:google_auth])
    google_auth.authorization.code = params[:code] if params[:code]

    google_auth.authorization.fetch_access_token!

    http = Net::HTTP.new 'www.googleapis.com', 443
    http.use_ssl = true
    response = http.get "/oauth2/v1/userinfo?access_token=#{google_auth.authorization.access_token}"

    response = JSON.parse response.body
    session[:email] = response['email']
    redirect_to '/'
  end

end