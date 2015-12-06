class Freelancer < ActiveRecord::Base
	belongs_to :user
	
	delegate :name ,:firstname,:lastname,:email , :to => :user, :allow_nil => true

	scope :active ,lambda { joins(:user).where("#{User.table_name}.role IN (1,2)")}
	scope :live_search, lambda {|search| joins(:user).where("(LOWER(#{User.table_name}.firstname) LIKE LOWER(:p) OR
                                               LOWER(#{User.table_name}.lastname) LIKE LOWER(:p) OR
                                               LOWER(#{Freelancer.table_name}.location) LIKE LOWER(:p) OR
                                               LOWER(#{Freelancer.table_name}.skills) LIKE LOWER(:p))",
                                               {:p => "%" + search.downcase + "%"})}


	def self.reject_freelancer(attributes)
		exists = attributes['id'].present?
		empty = %w(online_portfolio company_name contact_name contact_email).map{|name| attributes[name].blank?}.all?
		return empty.nil?
	end
end
