class AddSubjectToInMessage < ActiveRecord::Migration
  def change

  	add_column :in_messages, :subject, :string

  	add_index :in_messages , :from_id
  	add_index :in_messages, :to_id
  	add_index :in_messages, :token
  	add_index :in_messages, :subject
  end
end
