class Profile < ActiveRecord::Base
	belongs_to :user
	delegate :name ,:firstname,:lastname,:email , :to => :user, :allow_nil => true
# :searchable,:public_email,:location,:job_title,:company_name,:company_website,:online_portfolio,:linkedin_profile,:behance,:vimeo,:social_links,:skills
	scope :active ,lambda { joins(:user).where("#{User.table_name}.role = 1 AND #{Profile.table_name}.searchable = 1")}
	scope :live_search, lambda {|search| joins(:user).where("(LOWER(#{User.table_name}.firstname) LIKE LOWER(:p) OR
                                               LOWER(#{User.table_name}.lastname) LIKE LOWER(:p) OR
                                               LOWER(#{Profile.table_name}.location) LIKE LOWER(:p) OR
                                               LOWER(#{Profile.table_name}.skills) LIKE LOWER(:p))",
                                               {:p => "%" + search.downcase + "%"})}

	scope :skill_search, lambda {|search| joins(:user).where("LOWER(#{Profile.table_name}.skills) LIKE LOWER(:p)",
                                               {:p => "%" + search.downcase + "%"})}
	serialize :skills, Array 


	def self.reject_profile(attributes)
		exists = attributes['id'].present?
		empty = %w(searchable public_email location job_title company_name company_website online_portfolio linkedin_profile behance vimeo social_links skills).map{|name| attributes[name].blank?}.all?
		return empty.nil?
	end

	def is_freelancer?
		!!is_freelancer
	end

	def is_company?
		!!is_company
	end

	def skills=(arg)
    if arg.is_a?(Array)
      values = arg.compact.map {|a| a.to_s.strip}.reject(&:blank?)
      write_attribute(:skills, values)
    else
      self.skills = arg.to_s.split(/[\n\r]+/)
    end
  end
	
end

