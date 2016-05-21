# require 'carrierwave/orm/activerecord'

class Attachment < ActiveRecord::Base
	mount_uploader :attachment, AvatarUploader
	belongs_to :user
end
