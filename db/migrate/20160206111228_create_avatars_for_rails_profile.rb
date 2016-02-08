class CreateAvatarsForRailsProfile < ActiveRecord::Migration
  def up    
    add_attachment :profiles, :logo
  end
  
  def self.down
    remove_attachment :profiles, :logo
  end
end
