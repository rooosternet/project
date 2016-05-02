class TeamProfile < ActiveRecord::Base
  belongs_to :team
  belongs_to :profile
  validates_uniqueness_of :profile_id, scope: :team_id

  after_create :add_to_my_contacts
  before_destroy :remove_from_teams

  private

  def add_to_my_contacts
  	if self.team.backet == false
  		TeamProfile.find_or_create_by({profile_id: self.profile_id , team_id: User.current.my_contacts_team.id})
  	end		
  end

  def remove_from_teams
  	if self.team.backet == true
  		TeamProfile.where("team_id != #{self.team_id} and profile_id = #{self.profile_id}").map(&:delete)
  	end		
  end

end
