class ProfileConnects < ActiveRecord::Migration
	def change
		create_table(:profile_connects) do |t|
			t.references :profile
			t.string :provider
			t.string :uid
			t.string :name 
			t.string :email 
			t.string :nickname 
			t.string :first_name 
			t.string :last_name 
			t.string :location 
			t.string :description 
			t.string :image 
			t.string :phone 
			t.string :headline 
			t.string :industry 
			t.string :urls
			t.string :secret
			t.string :oauth_token
			t.datetime :oauth_expires_at
			t.timestamps
		end
	end
end


