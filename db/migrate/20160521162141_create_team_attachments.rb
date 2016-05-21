class CreateTeamAttachments < ActiveRecord::Migration
	def change
		create_table :team_attachments do |t|
			t.references :team
			t.string     :attachment
			t.string     :attachment_type
			t.string	 :description
			t.timestamps 
		end
	end
end
