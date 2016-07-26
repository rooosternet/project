class AddInvitationHashToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :invitation_hash ,:string, :limit => 40
  end
end
