class User < ActiveRecord::Base
  
  attr_reader :raw_invitation_token
  
  enum role: [:pending ,:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_one :studio
  has_one :freelancer

  delegate :job_title ,:company_name ,:company_website , :to => :studio, :allow_nil => true
  delegate :online_portfolio,:linkedin_profile,:company_name,:contact_name,:contact_email,:behance,:vimeo,:skills,:location , :to => :freelancer, :allow_nil => true

  accepts_nested_attributes_for :studio, :allow_destroy => true, :update_only => true, :reject_if => proc {|attributes| Studio.reject_studio(attributes)}
  accepts_nested_attributes_for :freelancer, :allow_destroy => true, :update_only => true, :reject_if => proc {|attributes| Freelancer.reject_freelancer(attributes)}

  def set_default_role
    self.role ||= ["yossi@roooster.net","sam@roooster.net","rotem@roooster.net"].include?(self.email) ?  :admin : :user 
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :validatable
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable , :confirmable
  
  validates_presence_of :firstname,:lastname,:email
  # validates_presence_of :firstname,:email
  validates_length_of :firstname, :lastname, :maximum => 30
  # before_validation  :generate_password_if_needed
  before_create :set_name
  # after_create :send_welcome_mail 
  # before_destroy 
  # after_save 

  def send_invite_mail(inviter)
     generate_invitation_token! unless @raw_invitation_token
     self.update_attribute :invitation_sent_at, Time.now.utc unless self.invitation_sent_at
     email = Mailer.invite_email(inviter,self,@raw_invitation_token).deliver_now  
  end

  # def send_welcome_mail
  #   begin
  #     return true if self.role.eql?("admin")
      
  #     if self.studio?
  #       Mailer.welcome_email(self).deliver_now 
  #     elsif self.freelancer?
  #       Mailer.welcome_email_freelancer(self).deliver_now 
  #     end  
            
  #   rescue Exception => e 
  #     return false
  #   end
  #   true
  #   #deliver_later 
  # end

  def freelancer?
    !self.freelancer.nil?
  end

  def studio?
    !self.studio.nil?
  end

  def pending?
    self.role.eql?("pending")
  end

  def user_need_to_edit_profile?
      !self.edit_profile
  end

  def user_type_str
   
    if self.role.eql?("admin")
      "modal-edit-profile-admin"
    elsif studio
      "modal-edit-profile-studio"
    elsif freelancer
      "modal-edit-profile-freelancer"
    else
      ""
    end      
          
  end

  private

  def set_name
  	self.name = "#{firstname} #{lastname}"	if self.name.blank?
  end

#   def generate_password_if_needed
#     if new_record?
#       length = [5, 10].max
#       random_password(length)
#     end
#   end

# # Generate and set a random password on given length
# def random_password(length=40)
#   chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
#   chars -= %w(0 O 1 l)
#   _password = ''
#   length.times {|i| _password << chars[SecureRandom.random_number(chars.size)] }
#   _password = ["yossi@roooster.net","sam@roooster.net","rotem@roooster.net"].include?(self.email) ? "1q2w3e4r" : _password
#   puts "---------- #{self.email}  #{_password}"
#   self.password = _password
#   self.password_confirmation = _password
#   self
# end

end



