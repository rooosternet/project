class UserPreference < ActiveRecord::Base
  belongs_to :user
  serialize :others

  # attr_protected :others, :user_id

  before_save :set_others_hash

  def initialize(attributes=nil, *args)
    super
    self.others ||= {}
  end

  def set_others_hash
    self.others ||= {}
  end

  def [](attr_name)
    if has_attribute? attr_name
      super
    else
      others ? others[attr_name] : nil
    end
  end

  def []=(attr_name, value)
    if has_attribute? attr_name
      super
    else
      h = (read_attribute(:others) || {}).dup
      h.update(attr_name => value)
      write_attribute(:others, h)
      value
    end
  end

  def teams_order; self[:teams_order] end
  def teams_order=(order); self[:teams_order]=order end

end
