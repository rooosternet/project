module ApplicationHelper

	def favicon
		"<link rel='shortcut icon' type='image/x-icon' href='#{image_path('favicon.ico')}' />".html_safe
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

end