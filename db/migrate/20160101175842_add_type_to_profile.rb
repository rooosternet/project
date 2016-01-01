class AddTypeToProfile < ActiveRecord::Migration
  def change
  	add_column :profiles, :is_company, :boolean , null: false, default: false
  	add_column :profiles, :is_freelancer, :boolean , null: false, default: false
  end
end