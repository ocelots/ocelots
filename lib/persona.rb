require 'net/http'

module Persona
  def verify_persona
    if params['assertion']
      http = Net::HTTP.new 'persona.org', 443
      http.use_ssl = true
      response = http.post '/verify',
        "audience=#{request.host_with_port}&assertion=#{params['assertion']}",
        { 'Content-Type' => 'application/x-www-form-urlencoded' }
      begin
        response = JSON.parse response.body
        yield response['email'], response if response['status'] == 'okay'
      rescue JSON::ParserError
        logger.info 'PersonaId returned invalid JSON'
      end
    end
  end
end