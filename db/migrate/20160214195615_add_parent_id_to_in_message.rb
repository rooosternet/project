class AddParentIdToInMessage < ActiveRecord::Migration
  def change
  	add_column :in_messages, :parent_id, :integer
  	add_index :in_messages , :parent_id
  end
end
