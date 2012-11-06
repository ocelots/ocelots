require 'team_filter'

module Api
  class AntechamberController < ApplicationController
    include TeamFilter

    def index
      messages = []
      with_team do |team|
        messages = team.messages.order 'created_at desc'
      end
      render json: messages.map(&:api_attributes)
    end
  end
end