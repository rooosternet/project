class Studio < ActiveRecord::Base
	belongs_to :user
	
	delegate :name ,:firstname,:lastname,:email , :to => :user, :allow_nil => true



	def self.reject_studio(attributes)
		exists = attributes['id'].present?
		empty = %w(company_name).map{|name| attributes[name].blank?}.all?
		return empty.nil?
	end

end
