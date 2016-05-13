class CreateUserPreferences < ActiveRecord::Migration
	def change
		create_table :user_preferences do |t|
			t.column "user_id", :integer, :default => 0, :null => false
			t.column "others", :text
		end
	end
end
