class AddEditProfileFlg < ActiveRecord::Migration
  def change
  	add_column :users, :edit_profile, :boolean , null: false, default: false
  end
end
