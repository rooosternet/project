class ProfileConnect < ActiveRecord::Base

	belongs_to :profile
	# belongs_to :user , :through => :profile
	# belongs_to :user , :class_name => :user , :foreign_key => :user_id

	def self.to_attributes(auth_hash)
		case auth_hash['provider']
		when 'twitter'
			urls = auth_hash['info']['urls']["Twitter"]
		when 'vimeo'
			urls = auth_hash['info']['link']
		else
			urls = auth_hash['info']['urls']["public_profile"]
		end
		{
			profile_id: User.current.profile.try(:id),
			provider: auth_hash['provider'],
			uid: auth_hash['uid'],
			name: auth_hash['info']['name'] || "#{auth_hash['info']['first_name']} #{auth_hash['info']['last_name']}",
			first_name: auth_hash['info']['first_name'],
			last_name: auth_hash['info']['last_name'],
			nickname: auth_hash['info']['nickname']    ,
			email: auth_hash['info']['email'] ? auth_hash['info']['email'] : "#{auth_hash['uid']}@#{auth_hash['provider']}.com",
			image: auth_hash['info']['image'],
			location: auth_hash['info']['location'] ,
			description: auth_hash['info']['description'] ,
			phone: auth_hash['info']['phone'] ,
			headline: auth_hash['info']['headline'] ,
			industry: auth_hash['info']['industry'] ,
			urls: urls,
			website: auth_hash['provider'].eql?("twitter") ? auth_hash['info']['urls']["Website"] : ""
		}
	end

	def self.create_with_auth_hash(auth_hash)
		unless pc = ProfileConnect.where(provider: auth_hash['provider'], uid: auth_hash['uid']).first
			create!(ProfileConnect.to_attributes(auth_hash))
		else
			pc.update_attributes(ProfileConnect.to_attributes(auth_hash))
			pc.save
		end
	end

	def profile_url
		self.urls
	end

	def image_url
		self.image
	end

end

