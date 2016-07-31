class UniqTeamName < ActiveRecord::Migration
  def change
  	add_index :teams, [:name,:owner_id], unique: true
  end
end
