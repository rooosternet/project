class User < ActiveRecord::Base
  enum role: [:pending ,:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_one :studio
  has_one :freelancer

  delegate :job_title ,:company_name ,:company_website , :to => :studio, :allow_nil => true
  delegate :online_portfolio,:linkedin_profile,:company_name,:contact_name,:contact_email,:behance,:vimeo,:skills,:location , :to => :freelancer, :allow_nil => true


  accepts_nested_attributes_for :studio, :allow_destroy => true, :update_only => true, :reject_if => proc {|attributes| Studio.reject_studio(attributes)}
  accepts_nested_attributes_for :freelancer, :allow_destroy => true, :update_only => true, :reject_if => proc {|attributes| Freelancer.reject_freelancer(attributes)}

  def set_default_role
    self.role ||= :pending
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :validatable
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable
  
  validates_presence_of :firstname,:lastname,:email
  validates_length_of :firstname, :lastname, :maximum => 30
  before_validation  :generate_password_if_needed
  before_create :set_name
  # before_destroy 
  # after_save 

  private

  def set_name
  	self.name = "#{firstname} #{lastname}"	if self.name.blank?
  end

  def generate_password_if_needed
    unless new_record? && self.encrypted_password.blank?
      length = [5, 10].max
      random_password(length)
    end
  end

# Generate and set a random password on given length
  def random_password(length=40)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    chars -= %w(0 O 1 l)
    _password = ''
    length.times {|i| _password << chars[SecureRandom.random_number(chars.size)] }
    puts "---------- #{self.email}  #{_password}"
    self.password = _password
    self.password_confirmation = password
    self
  end

end



