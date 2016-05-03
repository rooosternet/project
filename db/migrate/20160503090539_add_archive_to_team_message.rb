class AddArchiveToTeamMessage < ActiveRecord::Migration
  def change
  	add_column :teams , :archive ,:boolean, null: false, default: false
  	add_index :teams , :archive
  	add_column :in_messages , :archive ,:text
  	# add_index :in_messages , :archive
  end
end
