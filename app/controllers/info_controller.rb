class InfoController < ApplicationController

	include ApplicationHelper
	helper :application

	def about
	end

	def blog
		@blog_posts = Post.intros.paginate(page: params[:page], per_page: 3)
		@normalize_blog_posts = normalize_posts(@blog_posts)
	end

	# def post
	# 	byebug
	# 	@post = fetch_blog_posts.select{|x| x[:title] == params[:name]}
	# end

	def faq
		
	end

	def contact_us
		unless request.get?
		  email = Mailer.contact_us(params[:message]).deliver_later if params[:message].is_a?(Hash)
	      redirect_to root_path
	    end	
	end

end