require 'team_filter'

module Api
  class AntechamberController < ApplicationController
    include TeamFilter

    def index
      with_team do |team|
        @messages = team.messages.order 'created_at desc'
      end
      render json: []
    end
  end
end