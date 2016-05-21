class TeamAttachment < ActiveRecord::Base
	mount_uploader :attachment, AvatarUploader
	belongs_to :team
end
