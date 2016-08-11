class Team < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'

  has_many :attachments, :class_name => 'TeamAttachment', :foreign_key => 'team_id'
  accepts_nested_attributes_for :attachments

  has_many :team_profiles
  has_many :profiles, through: :team_profiles

  scope :archive ,lambda { where("#{Team.table_name}.archive = O") }
  scope :notarchive ,lambda { where("#{Team.table_name}.archive = 1") }
  scope :my ,lambda { include(:team_profiles).where("#{Team.table_name}.owner_id = #{User.current.id}")}

  accepts_nested_attributes_for :team_profiles, :allow_destroy => true

  validates_uniqueness_of :name, scope: :owner_id, :case_sensitive => false



  def team_image
    self.image.blank? ? "team1.jpg" : "#{self.image}"
  end

  def backet?
    !!self.backet
  end

  def self.next_id(user)
    unless (_names = user.teams.order(:name).pluck(:name).select{|team| team.downcase.match(/team.\d\d+$/)}).blank?
      _index = _names.last.try(:split," ").try(:last).try(:to_i)
    end
    _index.nil? ? 1 : (_index+1)
  end

  def pending_profiles
    self.team_profiles.where(invitation_status:['pending','declined'])
  end

end
