class Engagement < ActiveRecord::Base
  belongs_to :team
  belongs_to :organisation
end
