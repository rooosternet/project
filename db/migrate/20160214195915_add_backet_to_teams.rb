class AddBacketToTeams < ActiveRecord::Migration
  def change
	add_column :teams , :backet ,:boolean, null: false, default: false
  end
end
