class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :image
      t.text :description
      t.integer :owner_id
      t.boolean :public , null: false, default: false
      t.timestamps null: false
    end
  end
end
