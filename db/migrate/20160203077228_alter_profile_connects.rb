class AlterProfileConnects < ActiveRecord::Migration
	def change
		add_column :profile_connects, :website, :string
	end
end


