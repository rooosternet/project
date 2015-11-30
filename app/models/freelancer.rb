class Freelancer < ActiveRecord::Base
	belongs_to :user
	
	delegate :name ,:firstname,:lastname,:email , :to => :user, :allow_nil => true


	def self.reject_freelancer(attributes)
		exists = attributes['id'].present?
		empty = %w(online_portfolio company_name contact_name contact_email).map{|name| attributes[name].blank?}.all?
		return empty.nil?
	end
end
