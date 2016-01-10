class DeleteFreelancerStudio < ActiveRecord::Migration
  def change
  	drop_table 'freelancers'
  	drop_table 'studios'
  end
end
