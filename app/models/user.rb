class User < ActiveRecord::Base
  has_many :attachments
  accepts_nested_attributes_for :attachments

  attr_reader :raw_invitation_token
  attr_accessor :terms_of_service

  has_many :teams ,->{ where(backet: false , archive: false)}, :class_name => 'Team', :foreign_key => 'owner_id'

  enum role: [:pending ,:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  # has_one :studio
  # has_one :freelancer

  has_one :profile
  delegate :searchable,:public_email,:location,:job_title,:company_name,:company_website,:online_portfolio,:linkedin_profile,:behance,:vimeo,:social_links,:skills , :to => :profile, :allow_nil => true

  has_many :outgoing_messages , :class_name => 'InMessage' , :foreign_key => 'from_id'
  has_many :incoming_messages , :class_name => 'InMessage' , :foreign_key => 'to_id'
  has_many :profile_connects , :through => :profile
  has_one :preference, :dependent => :destroy, :class_name => 'UserPreference'

  # delegate :job_title ,:company_name ,:company_website , :to => :studio, :allow_nil => true
  # delegate :online_portfolio,:linkedin_profile,:company_name,:contact_name,:contact_email,:behance,:vimeo,:skills,:location , :to => :freelancer, :allow_nil => true
  # accepts_nested_attributes_for :studio, :allow_destroy => true, :update_only => true, :reject_if => proc {|attributes| Studio.reject_studio(attributes)}
  # accepts_nested_attributes_for :freelancer, :allow_destroy => true, :update_only => true, :reject_if => proc {|attributes| Freelancer.reject_freelancer(attributes)}
  accepts_nested_attributes_for :profile, :allow_destroy => true #, :update_only => true, :reject_if => proc {|attributes| Profile.reject_profile(attributes)}

  def ordered_teams
    all_teams = []

    in_teams = profile.teams.where("team_profiles.invitation_status IN (?) and teams.name != ?", ['accepted', ''],'My contacts')
    in_teams.each { |team| all_teams << team }
    all_teams =  teams | all_teams
    if(ids=pref[:teams_order])
      all_teams.sort_by do |m|
        if ids.include?(m[:id])
          ids.index(m[:id])
        else
          10000
        end
      end
    else
      all_teams
    end
  end

  def pref
    self.preference ||= UserPreference.new(:user => self)
  end

  def my_contacts_team
    unless _team = Team.where(owner_id: self.id , backet: true).first
      _team = Team.where(name: 'My Contacts', owner_id: self.id , backet: true).first_or_create
    end
    _team
  end

  def set_default_role
    self.role ||= ["yossi@roooster.co","sam@roooster.co","rotem@roooster.co"].include?(self.email) ?  :admin : :user
    self.profile = Profile.new unless self.profile
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :validatable
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable , :confirmable, :validatable ,:omniauthable, omniauth_providers: [:linkedin,:twitter,:vimeo,:behance,:dribbble]


  validates_presence_of :firstname,:lastname,:email
  # validates_presence_of :firstname,:email
  validates_length_of :firstname, :lastname, :maximum => 30
  validates :terms_of_service, :acceptance => true
  # before_validation  :generate_password_if_needed
  # before_create :set_name
  after_create :send_notification_mail
  # before_destroy
  # after_save
  # after_create :create_profile , :if => lambda{|user| user.user? && user.profile.nil?}

  # def create_profile
  #   self.profile = Profile.new
  #   self.save!
  # end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def send_notification_mail
    subject = nil
    unless User.current.nil?
      subject = "#{User.current.name} (#{User.current.email}) recommended #{self.name} (#{self.email})"
      Mailer.notification_mail(self,subject).deliver_later
    else
      Mailer.notification_mail(self).deliver_later
    end
  end

  def profile_image
    self.image.blank?  ? "user_default.jpg" :  self.image #(self.image.match(/http/) ? self.image : "#{self.image}.jpg")
  end

  class << self
    def current=(user)
      Thread.current[:current_user] = user
    end

    def current
      Thread.current[:current_user]
    end
  end

  def has_active_messages?
    InMessage.active_messages > 0
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

  def name
    "#{firstname} #{lastname}"
  end

  def profile?
    !self.profile.nil?
  end

  def admin?
    self.role.eql?("admin")
  end

  def user?
    self.role.eql?("user")
  end

  def user_need_to_edit_profile?
      !self.edit_profile
  end

  def user_type_str

    if self.role.eql?("admin")
      "modal-edit-profile-admin"
    elsif profile
      "modal-edit-profile"
    # elsif studio
    #   "modal-edit-profile-studio"
    # elsif freelancer
    #   "modal-edit-profile-freelancer"
    else
      ""
    end

  end

  def next_team_id
    unless (_names = teams.order(:name).pluck(:name).select{|team| team.downcase.match(/team.\d\d+$/)}).blank?
      _index = _names.last.try(:split," ").try(:last).try(:to_i)
    end
    _index.nil? ? 0 : _index
  end

  private

  # def set_name
  # 	self.name = "#{firstname} #{lastname}"	if self.name.blank?
  # end

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
#   _password = ["yossi@roooster.co","sam@roooster.co","rotem@roooster.co"].include?(self.email) ? "1q2w3e4r" : _password
#   puts "---------- #{self.email}  #{_password}"
#   self.password = _password
#   self.password_confirmation = _password
#   self
# end

end



