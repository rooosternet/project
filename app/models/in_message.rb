class InMessage < ActiveRecord::Base
	extend ActsAsTree::TreeView
	acts_as_tree order: "created_at"

	belongs_to :parent , :class_name => 'InMessage', :foreign_key => 'parent_id'

	belongs_to :from, :class_name => 'User', :foreign_key => 'from_id'
	belongs_to :to, :class_name => 'User', :foreign_key => 'to_id'
	
	validates_presence_of :from_id,:to_id,:note
	validates_presence_of :token , :if => lambda{|msg| !msg.new_record?}

	scope :inbox ,lambda { where("#{InMessage.table_name}.to_id = #{User.current.id}")}
	scope :outbox ,lambda { where("#{InMessage.table_name}.from_id = #{User.current.id}")}
	scope :allbox ,lambda { where("#{InMessage.table_name}.from_id = #{User.current.id} OR #{InMessage.table_name}.to_id = #{User.current.id}")}

	scope :active_messages , lambda { where("#{InMessage.table_name}.to_id = #{User.current.id} AND #{InMessage.table_name}.updated_at = #{InMessage.table_name}.created_at").count}

	before_create do
		self.token = Devise.friendly_token if @token.blank?
	end

	after_create :send_in_mail

	def send_in_mail
		email = Mailer.in_mail(self.from,self.to,self.token,self.note).deliver_later
	end

	def my_message?
		self.from_id == User.current.id
	end	
	
	def active?
		!my_message? && (self.updated_at == self.created_at)
	end

	def replay_to
		my_message? ? self.to : self.from
	end
	# def initialize(*args)
	# 	super
	# 	byebug	
	# 	# @token = Devise.friendly_token if @token.blank?
	# 	# @notify  = false if @notify.blank?
	# 	# @private = false if @private.blank?
	# end

end