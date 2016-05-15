module ApplicationHelper

	def profile_image(user,options={})
		# "<img alt="" src='#{user.profile_image}' >".html_safe
		options.merge!(src: image_url(user.profile_image))
		tag("img",options,false, false)
	end

	def profile_teams_classes(profile)
		profile.teams.pluck(:id).inject([]) do |memo,id|
			memo << "g-#{id}"
			memo
		end.flatten.join(' ') 
	end

	def team_images
		arr = []
		image = 1
		20.times do 
			arr << image_url("team#{image}.jpg")
			image+=1
		end	
		arr
	end

	def favicon
		"<link rel='shortcut icon' type='image/x-icon' href='#{image_path('favicon.ico')}' />".html_safe
	end

	def google_analytics
		render :partial => 'layouts/google_analytics'
	end

	def toggle_url_protocole(url = "#")
		unless url =~ /\A#{URI::regexp(['http', 'https'])}\z/
			url = "http://#{url}"
		end	
		# puts "URL: #{url}" if Rails.env.development?
		url
	end

	def generate_blog_posts_intro
		fetch_blog_posts[0..2]		
	end

	def fetch_blog_posts
		Rails.cache.fetch("intro_posts", expires_in: 24.hours) do 
			normalize_posts(Post.intros.to_a)
		end
	end

	def link_active_class(attribute,element=nil)
		if element
			element.respond_to?(attribute) && element.send(attribute).blank? ? "class=not-active" : ""
		else
			attribute.blank? ? "class=not-active" : ""
		end
	end

	def profile_connect_btn(provider,profile)
		if profile.connected_class(provider) == "btn-connected"
			link_to("Unlink", profile_connect_path(profile.connected(provider).first),method: :delete, target: '_blank', class: "btn btn-connected")
		else
			link_to("Link", user_omniauth_authorize_path(provider), target: '_blank', class: "btn btn-not-connected")
		end
	end	

	def profile_connect(provider,profile)
		if profile.connected_class(provider) == "btn-connected"
			check_box_tag "field-connect-#{provider}",'', true , class: "btn-connected social-link" , :"data-url" => profile_connect_path(profile.connected(provider).first),:"date-method" => :delete
			# link_to("Unlink", profile_connect_path(profile.connected(provider).first),method: :delete, target: '_blank', class: "btn btn-connected")
		else
			check_box_tag "field-connect-#{provider}",'', false , class: "btn-not-connected social-link", :"data-url" => user_omniauth_authorize_path(provider),:"date-method" => :get
			# link_to("Link", user_omniauth_authorize_path(provider), target: '_blank', class: "btn btn-not-connected")
		end
	end	

	def normalize_posts(posts)
		posts.inject([]) do |memo,post|
			memo ||=[]
			begin
				intro = post.post_content.split('<!--more-->')
				memo << {title: post.post_title , intro: intro[0] , full_post: intro[0] + intro[1] , created: post.post_date , link: post.guid}
			rescue Exception => e
			end
			memo
		end	
	end

	def skills_options_for_select(selected)
		options_for_select([["2D Animation","2D Animation"],
			["3D Animation Supervision","3D Animation Supervision"],
			["3D Character Animation","3D Character Animation"],
			["3D Character Modeling","3D Character Modeling"],
			["3D Modeling","3D Modeling"],
			["3D Look Dev","3D Look Dev"],
			["3D Vehicles","3D Vehicles"],
			["3D Weapons","3D Weapons"],
			["After Effects","After Effects"],
			["Animation","Animation"],
			["Art Direction","Art Direction"],
			["Branding","Branding"],
			["Cinema 4D","Cinema 4D"],
			["Character Animation","Character Animation"],
			["Character Design","Character Design"],
			["Character TD","Character TD"],
			["Compositor","Compositor"],
			["Concept Art","Concept Art"],
			["Cover Artwork","Cover Artwork"],
			["Design","Design"],
			["Digital Art","Digital Art"],
			["Digital Sculpting","Digital Sculpting"],
			["Director","Director"],
			["Environment Design","Environment Design"],
			["Fictional UI Design","Fictional UI Design"],
			["Film Director","Film Director"],
			["Flash Animation","Flash Animation"],
			["Graphic Design","Graphic Design"],
			["Hard Surface Modeling","Hard Surface Modeling"],
			["Illustration","Illustration"],
			["Maya","Maya"],
			["Matte painting","Matte painting"],
			["Mixed Media","Mixed Media"],
			["Motion Capture","Motion Capture"],
			["Motion Graphics","Motion Graphics"],
			["Movie Title Design","Movie Title Design"],
			["Mudbox","Mudbox"],
			["Music Composition","Music Composition"],
			["Nuke","Nuke"],
			["Lighting","Lighting"],
			["Logo Design","Logo Design"],
			["Rendering","Rendering"],
			["Rig","Rig"],
			["Screen Design","Screen Design"],
			["Sound Design","Sound Design"],
			["Shake","Shake"],
			["Stop Motion Animation","Stop Motion Animation"],
			["Story Board","Story Board"],
			["Supervisor","Supervisor"],
			["Texturing","Texturing"],
			["Texture Painting","Texture Painting"],
			["Traditional Animation","Traditional Animation"],
			["Typography","Typography"],
			["UI Design","UI Design"],
			["Vector Design","Vector Design"],
			["Video Editor","Video Editor"],
			["Vehicles Design","Vehicles Design"],
			["VFX Supervision","VFX Supervision"],
			["VFX","VFX"],
			["UV","UV"],
			["Zbrush","Zbrush"]], selected)

end

end


