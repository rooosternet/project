class InMessage < ActiveRecord::Base
	
	belongs_to :from, :class_name => 'User', :foreign_key => 'from_id'
	belongs_to :to, :class_name => 'User', :foreign_key => 'to_id'
	
	validates_presence_of :from_id,:to_id,:note
	validates_presence_of :token , :if => lambda{|msg| !msg.new_record?}

	scope :inbox ,lambda { where("#{InMessage.table_name}.to_id = User.current.id")}
	scope :outbox ,lambda { where("#{InMessage.table_name}.from_id = User.current.id")}

	before_create do
		self.token = Devise.friendly_token if @token.blank?
	end

	after_create :send_in_mail

	def send_in_mail
		email = Mailer.in_mail(self.from,self.to,self.token,self.note).deliver_later
	end

	# def initialize(*args)
	# 	super
	# 	byebug	
	# 	# @token = Devise.friendly_token if @token.blank?
	# 	# @notify  = false if @notify.blank?
	# 	# @private = false if @private.blank?
	# end

end