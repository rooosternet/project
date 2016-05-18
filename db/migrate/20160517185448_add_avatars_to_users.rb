class AddAvatarsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatars, :text
  end
end
