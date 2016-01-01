class CreateProfile < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user
      t.boolean :searchable , null: false, default: false
      t.string :public_email
      t.string :location
      t.string :job_title
      t.string :company_name
      t.string :company_website
      t.string :online_portfolio
      t.string :linkedin_profile
      t.string :behance
      t.string :vimeo
      t.text   :social_links
      t.text   :skills
      t.timestamps null: false
    end
    add_index :profiles, :user_id
    # add_index(:profiles, [:user_id, :searchable])
    # add_index(:profiles, [:user_id, :location])
  end
end
