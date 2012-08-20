require 'net/http'

class HomeController < ApplicationController
  skip_filter :require_login, only: [:index, :verify]

  def index
    if logged_in?
      redirect_to :home
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
    bid_resp = {}
    if params['assertion']
      http = Net::HTTP.new 'browserid.org', 443
      http.use_ssl = true
      response = http.post '/verify',
        "audience=#{request.host_with_port}&assertion=#{params['assertion']}",
        { 'Content-Type' => 'application/x-www-form-urlencoded' }
      begin
        bid_resp = JSON.parse response.body
        if bid_resp['status'] == 'okay'
          session[:email] = bid_resp['email']
        end
      rescue JSON::ParserError
        logger.info 'BrowserId returning bad JSON?'
      end
    end
    render json: bid_resp
  end
end