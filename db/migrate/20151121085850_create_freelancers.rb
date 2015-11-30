class CreateFreelancers < ActiveRecord::Migration
  def change
    create_table :freelancers do |t|
      t.references :user
      t.string :online_portfolio
      t.string :linkedin_profile
      t.string :behance
      t.string :vimeo
      t.text :skills
      t.string :location

      t.string :company_name
      t.string :contact_name
      t.string :contact_email
      
      t.timestamps null: false
    end

    add_index :freelancers, :user_id

  end
end