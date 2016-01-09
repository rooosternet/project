class CreateInMessages < ActiveRecord::Migration
  def change
    create_table :in_messages do |t|
      t.integer :from_id, null: false, default: false	
      t.integer :to_id  , null: false, default: false	
      t.text :note
      t.string :token
      t.boolean :notify , null: false, default: false	
      t.boolean :private , null: false, default: false	
      t.timestamps null: false
    end
  end
end