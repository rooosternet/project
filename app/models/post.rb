class Post < ActiveRecord::Base
	establish_connection "wordpress_production"
	self.table_name = 'wp_posts'

	scope :intros ,lambda { select("post_date,post_title,post_content,guid").where(post_status: 'publish',post_type: 'post').order("post_date desc").limit(10)}

end
