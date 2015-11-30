class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.references :user
      t.string :company_name
      t.string :job_title
      t.string :company_website

      t.timestamps null: false
    end

    add_index :studios, :user_id
    add_index :studios, :company_name
  end
end
