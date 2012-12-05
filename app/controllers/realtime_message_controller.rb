class Realtime_message_controller < WebsocketRails::BaseController
	def initialize_session
		# perform application setup here
		@message_count = 0
	end

	def new_message
		puts "Message from UID: #{client_id}\n ,the message is #{message}"
		#puts "Message from user: #{current_user.email}"
		@message_count = @message_count + 1
		broadcast_message :new_message, message
	end

end