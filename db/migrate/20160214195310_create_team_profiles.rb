class CreateTeamProfiles < ActiveRecord::Migration
  def change
    create_table :team_profiles do |t|
      t.references :team, index: true, foreign_key: true
      t.references :profile, index: true, foreign_key: true
      t.timestamps null: false
    end
    add_index :team_profiles, [:team_id,:profile_id], unique: true
  end
end
