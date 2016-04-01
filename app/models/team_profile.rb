class TeamProfile < ActiveRecord::Base
  belongs_to :team
  belongs_to :profile
  validates_uniqueness_of :profile_id, scope: :team_id
end
