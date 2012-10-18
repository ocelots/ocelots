require 'team_filter'

class AntechamberController < ApplicationController
  include TeamFilter

  def index
    with_team do |team|
      @message = Message.new
      @messages = team.messages
    end
  end
end