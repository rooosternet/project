class Team < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'

  has_many :team_profiles
  has_many :profiles, through: :team_profiles

  scope :archive ,lambda { where("#{Team.table_name}.archive = O") }
  scope :notarchive ,lambda { where("#{Team.table_name}.archive = 1") }
  scope :my ,lambda { include(:team_profiles).where("#{Team.table_name}.owner_id = #{User.current.id}")}

  accepts_nested_attributes_for :team_profiles, :allow_destroy => true

  def team_image
    self.image.blank? ? "team1.jpg" : "#{self.image}.jpg"
  end

  def backet?
    !!self.backet
  end
end
