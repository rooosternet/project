class Team < ActiveRecord::Base
	belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
	
	has_many :team_profiles
  	has_many :profiles, through: :team_profiles
end
