require 'team_filter'

class Realtime_message_controller < WebsocketRails::BaseController
	include TeamFilter

	def initialize_session
		@message_count = 0
	end

	def new_message
		 puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!I'm in here"
		 with_team(message[:slug]) do
			 @message = Message.create team: @team, person: current_person, content: message[:content]

			 puts "<<,<<<<<<<<<<<<<<<<<<<<<<<<<#{message}"
			 broadcast_message :new_message,render_to_string( partial: 'shared/one_message', locals: {message: @message})
		 end

	end

end