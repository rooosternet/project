module ApplicationHelper

	def favicon
		"<link rel='shortcut icon' type='image/x-icon' href='#{image_path('favicon.ico')}' />".html_safe
	end
end
