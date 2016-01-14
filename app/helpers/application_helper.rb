module ApplicationHelper

	def favicon
		"<link rel='shortcut icon' type='image/x-icon' href='#{image_path('favicon.ico')}' />".html_safe
	end

	def google_analytics
		 render :partial => 'layouts/google_analytics'
	end

	def generate_blog_posts_intro
		fetch_blog_posts[0..2]		
	end

	def fetch_blog_posts
		Rails.cache.fetch("intro_posts", expires_in: 24.hours) do 
			normalize_posts(Post.intros.to_a)
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


