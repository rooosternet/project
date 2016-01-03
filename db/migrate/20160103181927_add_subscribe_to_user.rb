class AddSubscribeToUser < ActiveRecord::Migration
  def change
  	add_column :users, :subscribe, :boolean , null: false, default: false
  end
end
