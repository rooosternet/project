class AddDescriptionAndAboutMeToProfile < ActiveRecord::Migration
  def change
     add_column :profiles, :description, :text
     add_column :profiles, :about_me, :text
  end
end
