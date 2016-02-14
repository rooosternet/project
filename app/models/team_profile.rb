class TeamProfile < ActiveRecord::Base
  belongs_to :team
  belongs_to :profile
end
