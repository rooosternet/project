class AddInvitationStatusToTeamProfile < ActiveRecord::Migration
  def change
    add_column :team_profiles, :invitation_status ,:string, :limit => 25
  end
end
