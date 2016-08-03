class AddTeamIdToInMessages < ActiveRecord::Migration
  def change
    add_column :in_messages, :team_id, :string
  end
end
