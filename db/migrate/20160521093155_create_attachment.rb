class CreateAttachment < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
    	t.references :user
    	t.string     :attachment
    	t.string     :attachment_type
    	t.string	 :description
    	t.timestamps 
    end
  end
end
