class AddIsAdminToTeamsProfile < ActiveRecord::Migration
  def change
    add_column :team_profiles, :is_admin ,:boolean, default: false, null: false
  end
end
